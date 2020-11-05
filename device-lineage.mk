# Active Edge
PRODUCT_PACKAGES += \
    ElmyraService

# AV media
PRODUCT_PACKAGES += \
    libavservices_minijail_vendor:32 \
    libcodec2_hidl@1.0.vendor:32 \
    libcodec2_vndk.vendor:64 \
    libmediaplayerservice

# Bluetooth
PRODUCT_PACKAGES += \
    com.qualcomm.qti.bluetooth_audio@1.0 \
    vendor.qti.hardware.bluetooth_audio@2.0.vendor

# Context Hub Runtime Environment
PRODUCT_PACKAGES += \
    chre

# Display
PRODUCT_PACKAGES += \
    libdisplayconfig \
    vendor.display.config@1.8

# DRM
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true \
    media.mediadrmservice.enable=true

# EUICC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

# Google Assistant
PRODUCT_PRODUCT_PROPERTIES += ro.opa.eligible_device=true

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.identity-support-lib.vendor:64 \
    libnos_client_citadel:64 \
    libcppbor.vendor:64 \
    libteeui_hal_support.vendor:64 \
    nos_app_avb:64 \
    nos_app_identity:64 \
    nos_app_keymaster:64 \
    nos_app_weaver:64 \
    vendor.qti.hardware.cryptfshw@1.0 \
    vendor.qti.hardware.cryptfshw@1.0.vendor

# Overlays
DEVICE_PACKAGE_OVERLAYS += device/google/crosshatch/overlay-lineage

# Perf
PRODUCT_PACKAGES += \
    vendor.qti.hardware.perf@1.0 \
    vendor.qti.hardware.perf@1.0.vendor \
    vendor.qti.hardware.perf@2.0.vendor

# Trust HAL
PRODUCT_PACKAGES += \
    vendor.lineage.trust@1.0-service

# Utilities
PRODUCT_PACKAGES += \
    libjson \
    libprotobuf-cpp-full-vendorcompat \
    libtinyxml

# WiFi
PRODUCT_PACKAGES += \
    libwifi-hal:64 \
    libwifi-hal-qcom
