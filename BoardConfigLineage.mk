#
# Copyright (C) 2018-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.lz4
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_ADDITIONAL_FLAGS := \
    DTC=$(shell pwd)/prebuilts/misc/$(HOST_OS)-x86/dtc/dtc \
    MKDTIMG=$(shell pwd)/prebuilts/misc/$(HOST_OS)-x86/libufdt/mkdtimg
TARGET_KERNEL_CONFIG := b1c1_defconfig
TARGET_KERNEL_SOURCE := kernel/google/msm-4.9
TARGET_NEEDS_DTBOIMAGE := true

# Manifests
DEVICE_MANIFEST_FILE += device/google/crosshatch/lineage_manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += vendor/lineage/config/device_framework_matrix.xml

# Partitions
AB_OTA_PARTITIONS += \
    vendor
ifneq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
    BOARD_VENDORIMAGE_PARTITION_SIZE := 805306368
endif
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Reserve space for gapps install
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_EXTFS_INODE_COUNT := -1
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 614400000
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := -1
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 975564914
endif
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 30720000
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 30720000

# SELinux
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy-lineage/dynamic
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy-lineage/vendor

# Verified Boot
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
