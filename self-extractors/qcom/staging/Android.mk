LOCAL_PATH := $(call my-dir)

ifneq ($(filter crosshatch, $(TARGET_DEVICE)),)
include $(CLEAR_VARS)
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE := ims
LOCAL_LICENSE_KINDS := SPDX-license-identifier-Apache-2.0
LOCAL_LICENSE_CONDITIONS := notice
LOCAL_NOTICE_FILE := $(LOCAL_PATH)/../COPYRIGHT $(LOCAL_PATH)/../LICENSE
LOCAL_MODULE_TAGS := optional
LOCAL_BUILT_MODULE_STEM := package.apk
LOCAL_MODULE_OWNER := qcom
LOCAL_MODULE_CLASS := APPS
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_CERTIFICATE := platform
# Disable dexpreopt and <uses-library> check because the APK depends on
# libraries that are not present as modules in the build system.
LOCAL_ENFORCE_USES_LIBRARIES := false
LOCAL_DEX_PREOPT := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE := QtiTelephonyService
LOCAL_LICENSE_KINDS := SPDX-license-identifier-Apache-2.0
LOCAL_LICENSE_CONDITIONS := notice
LOCAL_NOTICE_FILE := $(LOCAL_PATH)/../COPYRIGHT $(LOCAL_PATH)/../LICENSE
LOCAL_MODULE_TAGS := optional
LOCAL_BUILT_MODULE_STEM := package.apk
LOCAL_MODULE_OWNER := qcom
LOCAL_MODULE_CLASS := APPS
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_CERTIFICATE := platform
# Disable dexpreopt and <uses-library> check because the APK depends on
# libraries that are not present as modules in the build system.
LOCAL_ENFORCE_USES_LIBRARIES := false
LOCAL_DEX_PREOPT := false
include $(BUILD_PREBUILT)
endif
