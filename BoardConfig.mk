#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := device/letv/s2

TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Platform
TARGET_BOARD_PLATFORM := msm8952
TARGET_BOARD_PLATFORM_GPU := qcom-adreno510

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53.a57

TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := MSM8952

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlyprintk
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb

BOARD_RAMDISK_OFFSET := 0x02000000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_APPEND_DTB := true

TARGET_KERNEL_SOURCE := kernel/letv/msm8952
TARGET_KERNEL_CONFIG := cm_s2_defconfig
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-

BOARD_DTBTOOL_ARGS := -2

#ENABLE_CPUSETS := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864 
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864 
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4294967296 
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57033579520
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432

TARGET_USERIMAGES_USE_EXT4 := true

# Init
TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
BOARD_NEEDS_VENDORIMAGE_SYMLINK := true
TARGET_COPY_OUT_VENDOR := system
TARGET_UNIFIED_DEVICE := true
TARGET_USES_OVERLAY := true

# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_QC_TIME_SERVICES := true
TARGET_POWERHAL_VARIANT := qcom

# RIL
TARGET_RIL_VARIANT := caf

# Adreno
HAVE_ADRENO_SOURCE:= false
OVERRIDE_RS_DRIVER:= libRSDriver_adreno.so

# Audio
AUDIO_FEATURE_ENABLED_KPI_OPTIMIZE := true
AUDIO_FEATURE_ENABLED_NEW_SAMPLE_RATE := true
BOARD_USES_ALSA_AUDIO := true
USE_CUSTOM_AUDIO_POLICY := 1

# Needed for VoLTE
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := trueue
QCOM_BT_USE_BTNV := true
QCOM_BT_USE_SMD_TTY := true

# Camera
USE_CAMERA_STUB := true

# Crypto
TARGET_HW_DISK_ENCRYPTION := true
TARGET_KEYMASTER_WAIT_FOR_QSEE := true

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true

# Display
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_CONTINUOUS_SPLASH_ENABLED := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
USE_OPENGL_RENDERER := true

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

# Keymaster
TARGET_PROVIDES_KEYMASTER := true

# Lights
BOARD_LIGHTS_VARIANT := aw2013
TARGET_PROVIDES_LIBLIGHT := true

# Malloc
MALLOC_IMPL := dlmalloc

# Media
TARGET_HAVE_SIGNED_VENUS_FW := true

# Peripheral manager
TARGET_PER_MGR_ENABLED := true

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_HAS_QCOM_WLAN_SDK := true
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
TARGET_USES_QCOM_WCNSS_QMI := true
TARGET_USES_WCNSS_CTRL := true
WIFI_DRIVER_FW_PATH_AP := "ap"
WIFI_DRIVER_FW_PATH_STA := "sta"
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Cyanogen hardware
BOARD_HARDWARE_CLASS += hardware/cyanogen/cmhw
BOARD_USES_CYANOGEN_HARDWARE := true

# Twrp
#RECOVERY_VARIANT := twrp
ifeq ($(RECOVERY_VARIANT),twrp)
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/twrp/fstab.qcom
BOARD_HAS_NO_REAL_SDCARD := true
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_NTFS_3G := true
else
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/fstab.qcom
endif

# Recovery
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Sepolicy
BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/sepolicy
include device/qcom/sepolicy/sepolicy.mk

# inherit from the proprietary version
-include vendor/letv/s2/BoardConfigVendor.mk
