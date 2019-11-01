# Overlays
DEVICE_PACKAGE_OVERLAYS += device/google/crosshatch/blueline/overlay-lineage
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += device/google/crosshatch/blueline/overlay-lineage/lineage-sdk

$(call inherit-product, device/google/crosshatch/device-lineage.mk)
