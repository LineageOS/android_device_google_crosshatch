PRODUCT_PUBLIC_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/public
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/private

# vendors
BOARD_VENDOR_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/vendor/qcom/common
BOARD_VENDOR_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/vendor/qcom/sdm845
BOARD_VENDOR_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/vendor/google
BOARD_VENDOR_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/vendor/verizon
BOARD_VENDOR_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/tracking_denials
BOARD_VENDOR_SEPOLICY_DIRS += hardware/google/pixel-sepolicy/ramdump/common

# Pixel-wide policies
BOARD_VENDOR_SEPOLICY_DIRS += hardware/google/pixel-sepolicy/powerstats

# system_ext
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/system_ext/private

# vendors for backward compatibility
ifeq ($(PRODUCT_USE_QC_SPECIFIC_SYMLINKS), true)
BOARD_SEPOLICY_DIRS += device/google/crosshatch-sepolicy/vendor/qcom/compat
endif
