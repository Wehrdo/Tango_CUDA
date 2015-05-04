LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := cuda_jni_example
LOCAL_ARM_NEON := true
LOCAL_CFLAGS := -std=c++11 -Werror -fno-short-enums
LOCAL_SRC_FILES := native.cpp
LOCAL_LDLIBS := -llog -lz -L$(SYSROOT)/usr/lib \
                -L/home/dawehr/NVPACK/cuda_android/lib -lcudart_static
LOCAL_STATIC_LIBRARIES := libgpuCode_prebuilt
include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE := libgpuCode_prebuilt
LOCAL_SRC_FILES := libgpuCode.a
include $(PREBUILT_STATIC_LIBRARY)
