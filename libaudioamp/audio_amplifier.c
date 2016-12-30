/*
 * Copyright (C) 2013-2014, The CyanogenMod Project
 * Copyright (C) 2017 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <time.h>
#include <system/audio.h>

#include <voice.h>
#include <msm8916/platform.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <ctype.h>
#include <dlfcn.h>
#include <sys/ioctl.h>

#define LOG_NDEBUG 0
#define LOG_TAG "AudioAmp-tfa9890"
#include <log/log.h>

#include <hardware/audio_amplifier.h>

#define TFA_I2CSLAVEBASE        0x34

#ifndef I2C_SLAVE
#define I2C_SLAVE	0x0703	/* dummy address for building API	*/
#endif

int smartpa_fd = 0;
int tfa98xxI2cSlave = TFA_I2CSLAVEBASE;

typedef struct tfa9890_device {
    amplifier_device_t amp_dev;
    void *lib_ptr;
    void (*speakeron)();
    void (*calibration)();
    void (*speakeroff)();
} tfa9890_device_t;

static tfa9890_device_t *tfa9890_dev = NULL;

static int is_speaker(uint32_t snd_device) {
    int speaker = 0;

    switch (snd_device) {
        case SND_DEVICE_OUT_SPEAKER:
        case SND_DEVICE_OUT_SPEAKER_REVERSE:
        case SND_DEVICE_OUT_SPEAKER_AND_HEADPHONES:
        case SND_DEVICE_OUT_VOICE_SPEAKER:
        case SND_DEVICE_OUT_SPEAKER_AND_HDMI:
        case SND_DEVICE_OUT_SPEAKER_AND_USB_HEADSET:
        case SND_DEVICE_OUT_SPEAKER_AND_ANC_HEADSET:
            speaker = 1;
            break;
    }

    return speaker;
}

static int is_voice_speaker(uint32_t snd_device) {
    return snd_device == SND_DEVICE_OUT_VOICE_SPEAKER;
}

static int amp_enable_output_devices(hw_device_t *device, uint32_t devices, bool enable) {
    tfa9890_device_t *tfa9890 = (tfa9890_device_t*) device;

    ALOGD("%s\n", __func__);

    if (is_speaker(devices)) {
        if (enable) {
            ALOGD("%s: speaker amp on\n", __func__);
            tfa9890->speakeron();
        } else {
            ALOGD("%s: speaker amp off\n", __func__);
            tfa9890->speakeroff();
        }
    }
    return 0;
}

static int amp_dev_close(hw_device_t *device) {
    tfa9890_device_t *tfa9890 = (tfa9890_device_t*) device;

    ALOGD("%s\n", __func__);

    if (tfa9890) {
        dlclose(tfa9890->lib_ptr);
        free(tfa9890);
    }
    
    if (smartpa_fd) {
        close(smartpa_fd);
    }

    return 0;
}

static int amp_init(tfa9890_device_t *tfa9890) {

    ALOGD("%s\n", __func__);
    
    /*
    smartpa_fd = open("/dev/i2c_smartpa", O_RDWR);
    if (!smartpa_fd) {
        ALOGE("%s: Failed to open /dev/i2c_smartpa", __func__);
        return -EINVAL;
    } else {
        ALOGE("%s: Open /dev/i2c_smartpa success (%d)", __func__, smartpa_fd);
    }

    int res = ioctl(smartpa_fd, I2C_SLAVE, tfa98xxI2cSlave);
    */

    tfa9890->calibration();

    return 0;
}

static int amp_module_open(const hw_module_t *module,
        __attribute__((unused)) const char *name, hw_device_t **device)
{
    ALOGD("%s\n", __func__);
    
    if (tfa9890_dev) {
        ALOGE("%s:%d: Unable to open second instance of TFA9890 amplifier\n",
                __func__, __LINE__);
        return -EBUSY;
    }

    tfa9890_dev = calloc(1, sizeof(tfa9890_device_t));
    if (!tfa9890_dev) {
        ALOGE("%s:%d: Unable to allocate memory for amplifier device\n",
                __func__, __LINE__);
        return -ENOMEM;
    }

    tfa9890_dev->amp_dev.common.tag = HARDWARE_DEVICE_TAG;
    tfa9890_dev->amp_dev.common.module = (hw_module_t *) module;
    tfa9890_dev->amp_dev.common.version = HARDWARE_DEVICE_API_VERSION(1, 0);
    tfa9890_dev->amp_dev.common.close = amp_dev_close;

    tfa9890_dev->amp_dev.enable_output_devices = amp_enable_output_devices;

    tfa9890_dev->lib_ptr = dlopen("libtfa9890.so", RTLD_NOW);
    if (!tfa9890_dev->lib_ptr) {
        ALOGE("%s:%d: Unable to open libtfa9890.so: %s",
                __func__, __LINE__, dlerror());
        free(tfa9890_dev);
        return -ENODEV;
    }

    *(void **)&tfa9890_dev->speakeron = dlsym(tfa9890_dev->lib_ptr, "exTfa98xx_speakeron");
    *(void **)&tfa9890_dev->calibration = dlsym(tfa9890_dev->lib_ptr, "exTfa98xx_calibration");
    *(void **)&tfa9890_dev->speakeroff = dlsym(tfa9890_dev->lib_ptr, "exTfa98xx_speakeroff");
    
    /*
        exTfa98xx_LR_Switch
        exTfa98xx_setvolumestep
        exTfa98xx_getImped25
     */
    
    if (!tfa9890_dev->speakeron || !tfa9890_dev->calibration || !tfa9890_dev->speakeroff) {
        ALOGE("%s:%d: Unable to find required symbols", __func__, __LINE__);
        dlclose(tfa9890_dev->lib_ptr);
        free(tfa9890_dev);
        return -ENODEV;
    }

    if (amp_init(tfa9890_dev)) {
        dlclose(tfa9890_dev->lib_ptr);
        free(tfa9890_dev);
        return -ENODEV;
    }

    *device = (hw_device_t *) tfa9890_dev;

    return 0;
}

static struct hw_module_methods_t hal_module_methods = {
    .open = amp_module_open,
};

amplifier_module_t HAL_MODULE_INFO_SYM = {
    .common = {
        .tag = HARDWARE_MODULE_TAG,
        .module_api_version = AMPLIFIER_MODULE_API_VERSION_0_1,
        .hal_api_version = HARDWARE_HAL_API_VERSION,
        .id = AMPLIFIER_HARDWARE_MODULE_ID,
        .name = "S2 amplifier HAL",
        .author = "The LineageOS Project",
        .methods = &hal_module_methods,
    },
};
