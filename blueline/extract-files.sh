#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=blueline
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

function blob_fixup() {
    case "${1}" in
        vendor/rfs/msm/mpss/readonly/vendor/mbn/mcfg_sw/mbn_sw.txt)
            grep -q 'China/CT' "${2}" || echo '\
mcfg_sw/generic/China/CMCC/Commercial/Volte_OpenMkt/mcfg_sw.mbn
mcfg_sw/generic/China/CMCC/Lab/AGNSS_LocTech/mcfg_sw.mbn
mcfg_sw/generic/China/CMCC/Lab/Conf_VoLTE/mcfg_sw.mbn
mcfg_sw/generic/China/CMCC/Lab/EPS_Only/mcfg_sw.mbn
mcfg_sw/generic/China/CMCC/Lab/LPP_LocTech/mcfg_sw.mbn
mcfg_sw/generic/China/CMCC/Lab/Nsiot_VoLTE/mcfg_sw.mbn
mcfg_sw/generic/China/CMCC/Lab/RRLP_LocTech/mcfg_sw.mbn
mcfg_sw/generic/China/CMCC/Lab/TGL_Comb_Attach/mcfg_sw.mbn
mcfg_sw/generic/China/CMCC/Lab/W_IRAT_Comb_Attach/mcfg_sw.mbn
mcfg_sw/generic/China/CT/Commercial/hVoLTE_OpenMkt/mcfg_sw.mbn
mcfg_sw/generic/China/CT/Commercial/OpenMkt/mcfg_sw.mbn
mcfg_sw/generic/China/CT/Commercial/VoLTE_OpenMkt/mcfg_sw.mbn
mcfg_sw/generic/China/CT/Lab/CTA/mcfg_sw.mbn
mcfg_sw/generic/China/CT/Lab/TEST/mcfg_sw.mbn
mcfg_sw/generic/China/CT/Lab/TEST_EPS_ONLY/mcfg_sw.mbn
mcfg_sw/generic/China/CT/Lab/TEST_NO_APN/mcfg_sw.mbn
mcfg_sw/generic/China/CT/Lab/VoLTE_Conf/mcfg_sw.mbn
mcfg_sw/generic/China/CU/Commercial/OpenMkt/mcfg_sw.mbn
mcfg_sw/generic/China/CU/Commercial/VoLTE/mcfg_sw.mbn
mcfg_sw/generic/China/CU/Lab/Test/mcfg_sw.mbn' >> "${2}"
            ;;
    esac
}

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
extract "${MY_DIR}/proprietary-files-vendor.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
