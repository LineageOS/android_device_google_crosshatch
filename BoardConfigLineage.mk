# Common board config for crosshatch, blueline

BOARD_KERNEL_IMAGE_NAME := Image.lz4
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CONFIG := lineageos_crosshatch_defconfig
TARGET_KERNEL_SOURCE := kernel/google/msm-4.9

-include vendor/google/crosshatch/BoardConfigVendor.mk
