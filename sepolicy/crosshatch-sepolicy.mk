PRODUCT_PUBLIC_SEPOLICY_DIRS := device/google/crosshatch/sepolicy/public
PRODUCT_PRIVATE_SEPOLICY_DIRS := device/google/crosshatch/sepolicy/private

# vendors
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy/vendor/qcom/common
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy/vendor/qcom/sdm845
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy/vendor/google
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy/vendor/verizon

# vendors for backward compatibility
ifeq ($(PRODUCT_USE_QC_SPECIFIC_SYMLINKS), true)
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy/vendor/qcom/compat
endif
