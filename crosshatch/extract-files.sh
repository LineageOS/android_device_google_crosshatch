#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=crosshatch
VENDOR=google

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_FIRMWARE=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-firmware)
            ONLY_FIRMWARE=true
            ;;
        -n | --no-cleanup)
            CLEAN_VENDOR=false
            ;;
        -k | --kang)
            KANG="--kang"
            ;;
        -s | --section)
            SECTION="${2}"
            shift
            CLEAN_VENDOR=false
            ;;
        *)
            SRC="${1}"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/bin/hw/android.hardware.identity@1.0-service.citadel | \
            vendor/lib64/android.hardware.identity@1.0-impl.nos.so)
            [ "$2" = "" ] && return 0
            sed -i "s/android.hardware.identity-V3-ndk_platform.so/android.hardware.identity-V3-ndk.so\x00\x00\x00\x00\x00\x00\x00\x00\x00/" "${2}"
            sed -i "s/android.hardware.keymaster-V3-ndk_platform.so/android.hardware.keymaster-V3-ndk.so\x00\x00\x00\x00\x00\x00\x00\x00\x00/" "${2}"
            ;;
        vendor/bin/hw/android.hardware.rebootescrow-service.citadel)
            [ "$2" = "" ] && return 0
            sed -i "s/android.hardware.rebootescrow-V1-ndk_platform.so/android.hardware.rebootescrow-V1-ndk.so\x00\x00\x00\x00\x00\x00\x00\x00\x00/" "${2}"
            "${PATCHELF}" --replace-needed "libcrypto.so" "libcrypto-v33.so" "${2}"
            "${PATCHELF}" --add-needed "libcrypto_shim.so" "${2}"
            ;;
        vendor/lib64/android.hardware.keymaster@4.1-impl.nos.so | \
            vendor/lib64/libwvhidl@1.3.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --add-needed "libcrypto_shim.so" "${2}"
            ;;
        vendor/bin/hw/citadeld | \
            vendor/lib64/libnos_citadeld_proxy.so)
            [ "$2" = "" ] && return 0
            sed -i "s/android.frameworks.stats-V1-ndk_platform.so/android.frameworks.stats-V1-ndk.so\x00\x00\x00\x00\x00\x00\x00\x00\x00/" "${2}"
            "${PATCHELF}" --replace-needed "pixelatoms-cpp.so" "pixelatoms-cpp-legacy.so" "${2}"
            ;;
        vendor/bin/hw/vendor.qti.media.c2@1.0-service)
            [ "$2" = "" ] && return 0
            sed -i "s/libavservices_minijail_vendor.so/libavservices_minijail.so\x00\x00\x00\x00\x00\x00\x00/" "${2}"
            ;;
        vendor/lib64/hw/com.qti.chi.override.so)
            [ "$2" = "" ] && return 0
            sed -i "s/android.hardware.power-V1-ndk_platform.so/android.hardware.power-V1-ndk.so\x00\x00\x00\x00\x00\x00\x00\x00\x00/" "${2}"
            ;;
        *)
            return 1
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

function prepare_firmware() {
    if [ "${SRC}" != "adb" ]; then
        bash "${ANDROID_ROOT}"/lineage/scripts/pixel/prepare-firmware.sh "${DEVICE}" "${SRC}"
    fi
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

if [ -z "${ONLY_FIRMWARE}" ]; then
    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
    extract "${MY_DIR}/proprietary-files-carriersettings.txt" "${SRC}" "${KANG}" --section "${SECTION}"
    extract "${MY_DIR}/proprietary-files-radio.txt" "${SRC}" "${KANG}" --section "${SECTION}"
    extract "${MY_DIR}/proprietary-files-vendor.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

if [ -z "${SECTION}" ]; then
    extract_firmware "${MY_DIR}/proprietary-firmware.txt" "${SRC}"
fi

"${MY_DIR}/setup-makefiles.sh"
