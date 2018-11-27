# Common board config for crosshatch, blueline

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CONFIG := lineageos_crosshatch_defconfig
TARGET_KERNEL_SOURCE := kernel/google/crosshatch
BOARD_KERNEL_IMAGE_NAME := Image.lz4-dtb

-include vendor/google/crosshatch/BoardConfigVendor.mk
