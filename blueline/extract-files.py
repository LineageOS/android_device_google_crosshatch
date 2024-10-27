#!/usr/bin/env -S PYTHONPATH=../../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.extract import extract_fns_user_type
from extract_utils.extract_pixel import (
    extract_pixel_factory_image,
    extract_pixel_firmware,
    pixel_factory_image_regex,
    pixel_firmware_regex,
)
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'hardware/google/interfaces',
    'hardware/google/pixel',
    'hardware/qcom/sdm845',
    'hardware/qcom/wlan/legacy',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'vendor.qti.hardware.tui_comm@1.0',
        'vendor.qti.imsrtpservice@3.0',
    ): lib_fixup_vendor_suffix,
    (
        'libril',
        'libwpa_client',
    ): lib_fixup_remove,
}

blob_fixups: blob_fixups_user_type = {
    (
        'vendor/bin/hw/android.hardware.identity@1.0-service.citadel',
        'vendor/lib64/android.hardware.identity@1.0-impl.nos.so',
    ): blob_fixup()
        .replace_needed('android.hardware.identity-V3-ndk_platform.so', 'android.hardware.identity-V3-ndk.so')
        .replace_needed('android.hardware.keymaster-V3-ndk_platform.so', 'android.hardware.keymaster-V3-ndk.so'),
    'vendor/bin/hw/android.hardware.rebootescrow-service.citadel': blob_fixup()
        .replace_needed('android.hardware.rebootescrow-V1-ndk_platform.so', 'android.hardware.rebootescrow-V1-ndk.so')
        .replace_needed('libcrypto.so', 'libcrypto-v33.so')
        .add_needed('libcrypto_shim.so'),
    (
        'vendor/bin/hw/citadeld',
        'vendor/lib64/libnos_citadeld_proxy.so',
    ): blob_fixup()
        .replace_needed('android.frameworks.stats-V1-ndk_platform.so', 'android.frameworks.stats-V1-ndk.so')
        .replace_needed('pixelatoms-cpp.so', 'pixelatoms-cpp-legacy.so'),
    'vendor/bin/hw/vendor.qti.media.c2@1.0-service': blob_fixup()
        .replace_needed('libavservices_minijail_vendor.so', 'libavservices_minijail.so'),
    (
        'vendor/lib64/android.hardware.keymaster@4.1-impl.nos.so',
        'vendor/lib64/libwvhidl@1.3.so',
    ): blob_fixup()
        .add_needed('libcrypto_shim.so'),
    'vendor/lib64/hw/com.qti.chi.override.so': blob_fixup()
        .replace_needed('android.hardware.power-V1-ndk_platform.so', 'android.hardware.power-V1-ndk.so'),
}  # fmt: skip

extract_fns: extract_fns_user_type = {
    pixel_factory_image_regex: extract_pixel_factory_image,
    pixel_firmware_regex: extract_pixel_firmware,
}

module = ExtractUtilsModule(
    'blueline',
    'google',
    device_rel_path='device/google/crosshatch/blueline',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    add_firmware_proprietary_file=True,
    extract_fns=extract_fns,
)

module.add_proprietary_file('proprietary-files-carriersettings.txt')
module.add_proprietary_file('proprietary-files-radio.txt')
module.add_proprietary_file('proprietary-files-vendor.txt')

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
