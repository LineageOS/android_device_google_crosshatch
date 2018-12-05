################################################################################
# @file device/qcom/common/thermal-engine/Android.mk
# @Makefile for installing thermal-engine client header on Android.
################################################################################

LOCAL_PATH:= $(call my-dir)
<<<<<<< HEAD   (684445 b1c1: Set date for vendor and boot SPL)

include $(CLEAR_VARS)
LOCAL_MODULE := libThermal_headers
LOCAL_LICENSE_KINDS := SPDX-license-identifier-BSD
LOCAL_LICENSE_CONDITIONS := notice
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
LOCAL_VENDOR_MODULE := true
include $(BUILD_HEADER_LIBRARY)
=======
>>>>>>> CHANGE (0cfe5c b1c1: Use vendor/qcom/opensource/thermal-engine headers)
