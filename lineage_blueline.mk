# Boot animation
TARGET_SCREEN_HEIGHT := 2160
TARGET_SCREEN_WIDTH := 1080

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/google/crosshatch/aosp_blueline.mk)

-include device/google/crosshatch/blueline/device-lineage.mk

## Device identifier. This must come after all inclusions
PRODUCT_NAME := lineage_blueline
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel 3
TARGET_MANUFACTURER := Google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=blueline \
    PRIVATE_BUILD_DESC="blueline-user 11 RP1A.201105.002 6869500 release-keys"

BUILD_FINGERPRINT := google/blueline/blueline:11/RP1A.201105.002/6869500:user/release-keys

$(call inherit-product-if-exists, vendor/google/crosshatch/crosshatch-vendor.mk)
