# Common board config for crosshatch, blueline

BOARD_KERNEL_IMAGE_NAME := Image.lz4-dtb
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CONFIG := b1c1_defconfig
TARGET_KERNEL_SOURCE := kernel/google/crosshatch

-include vendor/google/crosshatch/BoardConfigVendor.mk
