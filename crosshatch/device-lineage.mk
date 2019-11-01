# Overlays
DEVICE_PACKAGE_OVERLAYS += device/google/crosshatch/crosshatch/overlay-lineage
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += device/google/crosshatch/crosshatch/overlay-lineage/lineage-sdk

$(call inherit-product, device/google/crosshatch/device-lineage.mk)
