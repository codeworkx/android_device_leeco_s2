LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_32_BIT_ONLY := true
LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := CameraWrapper.cpp

LOCAL_C_INCLUDES := \
    system/media/camera/include

LOCAL_CFLAGS := -Werror

LOCAL_SHARED_LIBRARIES := \
    libhardware liblog libcamera_client libutils libcutils libdl

include $(BUILD_SHARED_LIBRARY)
