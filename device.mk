#
# Copyright (C) 2016 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_SOONG_NAMESPACES += \
    device/google/crosshatch/pixelstats \
    device/google/crosshatch/usb \
    device/google/crosshatch/health \
    hardware/google/av \
    hardware/google/interfaces \
    hardware/qcom/sdm845 \
    vendor/qcom/sdm845

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

# enable cal by default on accel sensor
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.vendor.debug.sensors.accel_cal=1

# The default value of this variable is false and should only be set to true when
# the device allows users to retain eSIM profiles after factory reset of user data.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    masterclear.allow_retain_esim_profiles_after_fdr=true

PRODUCT_COPY_FILES += \
    device/google/crosshatch/default-permissions.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default-permissions/default-permissions.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:system/etc/permissions/android.software.verified_boot.xml

# Enforce privapp-permissions whitelist
PRODUCT_PROPERTY_OVERRIDES += \
    ro.control_privapp_permissions=enforce
PRODUCT_COPY_FILES += \
    device/google/crosshatch/permissions/privapp-permissions-aosp.xml:system/etc/permissions/privapp-permissions-aosp.xml

# Enable on-access verification of priv apps. This requires fs-verity support in kernel.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.apk_verity.mode=1

PRODUCT_PACKAGES += \
    messaging

LOCAL_PATH := device/google/crosshatch
SRC_MEDIA_HAL_DIR := hardware/qcom/media/sdm845
SRC_DISPLAY_HAL_DIR := hardware/qcom/display/sdm845

TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop

$(call inherit-product, $(LOCAL_PATH)/utils.mk)

ifeq ($(wildcard vendor/google_devices/crosshatch/proprietary/device-vendor-crosshatch.mk),)
    BUILD_WITHOUT_VENDOR := true
endif

PRODUCT_CHARACTERISTICS := nosdcard
PRODUCT_SHIPPING_API_LEVEL := 28

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.hardware.rc:root/init.recovery.$(PRODUCT_PLATFORM).rc \
    $(LOCAL_PATH)/init.hardware.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).rc \
    $(LOCAL_PATH)/init.hardware.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).usb.rc \
    $(LOCAL_PATH)/ueventd.hardware.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    $(LOCAL_PATH)/init.power.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).power.rc \
    $(LOCAL_PATH)/init.radio.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.radio.sh \
    $(LOCAL_PATH)/uinput-fpc.kl:system/usr/keylayout/uinput-fpc.kl \
    $(LOCAL_PATH)/uinput-fpc.idc:system/usr/idc/uinput-fpc.idc \
    $(LOCAL_PATH)/init.qcom.devstart.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.devstart.sh \
    $(LOCAL_PATH)/init.qcom.ipastart.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.ipastart.sh \
    $(LOCAL_PATH)/init.qcom.wlan.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.wlan.sh \
    $(LOCAL_PATH)/init.insmod.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.insmod.sh \
    $(LOCAL_PATH)/init.firstboot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.firstboot.sh \
    $(LOCAL_PATH)/thermal-engine-blueline-novr-evt.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-blueline-novr-evt.conf \
    $(LOCAL_PATH)/thermal-engine-blueline-vr-evt.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-blueline-vr-evt.conf \
    $(LOCAL_PATH)/thermal-engine-crosshatch-novr-evt.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-crosshatch-novr-evt.conf \
    $(LOCAL_PATH)/thermal-engine-crosshatch-vr-evt.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-crosshatch-vr-evt.conf \
    $(LOCAL_PATH)/thermal-engine-blueline-novr-prod.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-blueline-novr-prod.conf \
    $(LOCAL_PATH)/thermal-engine-blueline-vr-prod.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-blueline-vr-prod.conf \
    $(LOCAL_PATH)/thermal-engine-crosshatch-novr-prod.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-crosshatch-novr-prod.conf \
    $(LOCAL_PATH)/thermal-engine-crosshatch-vr-prod.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-crosshatch-vr-prod.conf \
    $(LOCAL_PATH)/init.ramoops.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.ramoops.sh

# Edge Sense initialization script.
# TODO: b/67205273
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.edge_sense.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.edge_sense.sh

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
  PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/init.hardware.diag.rc.userdebug:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).diag.rc
  PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/init.hardware.mpssrfs.rc.userdebug:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).mpssrfs.rc
  PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/init.hardware.chamber.rc.userdebug:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.$(PRODUCT_PLATFORM).chamber.rc
else
  PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/init.hardware.diag.rc.user:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).diag.rc
  PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/init.hardware.mpssrfs.rc.user:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).mpssrfs.rc
endif

#per device
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/crosshatch/init.crosshatch.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.crosshatch.rc \
    $(LOCAL_PATH)/blueline/init.blueline.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.blueline.rc \
    $(LOCAL_PATH)/init.common.rc:root/init.$(PRODUCT_HARDWARE).rc \
    $(LOCAL_PATH)/init.recovery.hardware.device.rc:root/init.recovery.crosshatch.rc \
    $(LOCAL_PATH)/init.recovery.hardware.device.rc:root/init.recovery.blueline.rc \

MSM_VIDC_TARGET_LIST := sdm845 # Get the color format from kernel headers
MASTER_SIDE_CP_TARGET_LIST := sdm845 # ION specific settings

# A/B support
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier

# Use Sdcardfs
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.sys.sdcardfs=1

PRODUCT_PACKAGES += \
    bootctrl.sdm845

PRODUCT_PROPERTY_OVERRIDES += \
    ro.cp_system_other_odex=1

# Script that copies preloads directory from system_other to data partition
PRODUCT_COPY_FILES += \
    device/google/crosshatch/preloads_copy.sh:system/bin/preloads_copy.sh

AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vbmeta \
    dtbo \
    product

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Enable update engine sideloading by including the static version of the
# boot_control HAL and its dependencies.
PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.sdm845 \
    libgptutils \
    libz \
    libcutils

PRODUCT_PACKAGES += \
    update_engine_sideload \
    sg_write_buffer

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml\
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml\
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.assist.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.assist.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.vr.headtracking-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vr.headtracking.xml \
    frameworks/native/data/etc/android.hardware.vr.high_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vr.high_performance.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.telephony.carrierlock.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.carrierlock.xml \
    frameworks/native/data/etc/android.hardware.strongbox_keystore.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.strongbox_keystore.xml \

# power HAL
PRODUCT_PACKAGES += \
    android.hardware.power@1.3-service.crosshatch-libperfmgr

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Audio fluence, ns, aec property, voice and media volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.sdk.audio.fluencetype=fluencepro \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.speaker=true \
    persist.audio.fluence.voicecomm=true \
    persist.audio.fluence.voicerec=false \
    ro.config.vc_call_vol_steps=7 \
    ro.config.media_vol_steps=25 \

# MaxxAudio effect and add rotation monitor
PRODUCT_PROPERTY_OVERRIDES += \
    ro.audio.monitorRotation=true

PRODUCT_PACKAGES += \
    libmalistener

# graphics
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196610

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.display.foss=1 \
    ro.vendor.display.paneltype=2 \
    ro.vendor.display.sensortype=2 \
    vendor.display.foss.config=1 \
    vendor.display.foss.config_path=/vendor/etc/FOSSConfig.xml

PRODUCT_PROPERTY_OVERRIDES += \
    vendor.display.dataspace_saturation_matrix=1.16868,-0.03155,-0.01473,-0.16868,1.03155,-0.05899,0.00000,0.00000,1.07372

PRODUCT_PROPERTY_OVERRIDES += \
    vendor.display.disable_decimation=1

# Enable camera EIS3.0
PRODUCT_PROPERTY_OVERRIDES += \
    persist.camera.is_type=5 \
    persist.camera.gzoom.at=0

# camera google face detection
PRODUCT_PROPERTY_OVERRIDES += \
    persist.camera.googfd.enable=1

# Enable logical camera as default (camera id 1)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.camera.logical.default=1

# Enable Treble camera shim to free buffers earlier than default
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.camera.free_buf_early=true

# OEM Unlock reporting
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.oem_unlock_supported=1

PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cne.feature=1 \
    persist.vendor.data.iwlan.enable=true \
    persist.radio.RATE_ADAPT_ENABLE=1 \
    persist.radio.ROTATION_ENABLE=1 \
    persist.radio.VT_ENABLE=1 \
    persist.radio.VT_HYBRID_ENABLE=1 \
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.data_ltd_sys_ind=1 \
    persist.radio.videopause.mode=1 \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.data_con_rprt=true \
    persist.vendor.radio.relay_oprt_change=1\
    persist.vendor.radio.no_wait_for_card=1\
    persist.rcs.supported=1 \
    vendor.rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so\
    ro.hardware.keystore_desede=true \

# Disable snapshot timer
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.snapshot_enabled=0 \
    persist.vendor.radio.snapshot_timer=0

# logical camera for dual front sensors
PRODUCT_PROPERTY_OVERRIDES += \
  persist.vendor.camera.multicam=1

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi_concurrency_cfg.txt:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wifi_concurrency_cfg.txt \
    $(LOCAL_PATH)/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini \

#ipacm configuration files
PRODUCT_COPY_FILES += \
    hardware/qcom/data/ipacfg-mgr/msm8998/ipacm/src/IPACM_cfg.xml:$(TARGET_COPY_OUT_VENDOR)/etc/IPACM_cfg.xml

PRODUCT_PACKAGES += \
    hwcomposer.sdm845 \
    android.hardware.graphics.composer@2.2-service \
    gralloc.sdm845 \
    android.hardware.graphics.mapper@2.0-impl-qti-display \
    vendor.qti.hardware.display.allocator@1.0-service

# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service.crosshatch

# Light HAL
PRODUCT_PACKAGES += \
    lights.$(PRODUCT_PLATFORM) \
    hardware.google.light@1.0-service

# Memtrack HAL
PRODUCT_PACKAGES += \
    memtrack.sdm845 \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service

# Bluetooth HAL
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl-qti \
    android.hardware.bluetooth@1.0-service-qti

# Bluetooth SoC
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.qcom.bluetooth.soc=cherokee

# Property for loading BDA from device tree
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.bt.bdaddr_path=/proc/device-tree/chosen/cdt/cdb2/bt_addr

# Bluetooth WiPower
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.bluetooth.emb_wp_mode=false \
    ro.vendor.bluetooth.wipower=false

# DRM HAL
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.1-service.clearkey \
    android.hardware.drm@1.1-service.widevine

# NFC and Secure Element packages
PRODUCT_PACKAGES += \
    NfcNci \
    Tag \
    SecureElement \
    android.hardware.nfc@1.1-service \
    android.hardware.secure_element@1.0-service-disabled

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    vendor.ese.loader_script_path=/sys/firmware/devicetree/base/soc/i2c@88c000/nq@28/ese/loader_scripts_path

PRODUCT_COPY_FILES += \
    device/google/crosshatch/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/libnfc-nci.conf \
    device/google/crosshatch/nfc/libese-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libese-nxp.conf \
    device/google/crosshatch/felica/loaderservice_updater_1.lss:$(TARGET_COPY_OUT_VENDOR)/etc/loaderservice_updater_1.lss \
    device/google/crosshatch/felica/loaderservice_updater_2.lss:$(TARGET_COPY_OUT_VENDOR)/etc/loaderservice_updater_2.lss

# TODO(b/72443662)
PRODUCT_COPY_FILES += \
    device/google/crosshatch/nfc/manifest_se_SIM1.xml:$(TARGET_COPY_OUT_VENDOR)/odm/etc/vintf/manifest_G013A.xml \
    device/google/crosshatch/nfc/manifest_se_eSE1.xml:$(TARGET_COPY_OUT_VENDOR)/odm/etc/vintf/manifest_G013B.xml \
    device/google/crosshatch/nfc/manifest_se_SIM1.xml:$(TARGET_COPY_OUT_VENDOR)/odm/etc/vintf/manifest_G013C.xml \
    device/google/crosshatch/nfc/manifest_se_eSE1.xml:$(TARGET_COPY_OUT_VENDOR)/odm/etc/vintf/manifest_G013D.xml

PRODUCT_PACKAGES += \
    android.hardware.usb@1.1-service.crosshatch

PRODUCT_PACKAGES += \
    libmm-omxcore \
    libOmxCore \
    libstagefrighthw \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc \
    libc2dcolorconvert

# Enable Codec 2.0
PRODUCT_PACKAGES += \
    libmedia_codecserviceregistrant \
    libqcodec2 \
    libstagefright_ccodec \
    vendor.qti.media.c2@1.0-service \

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64 \
    camera.device@3.2-impl \
    camera.sdm845 \
    libqomx_core \
    libmmjpeg_interface \
    libmmcamera_interface \
    libcameradepthcalibrator

PRODUCT_PACKAGES += \
    sensors.$(PRODUCT_HARDWARE) \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:vendor/etc/sensors/hals.conf

# Default permission grant exceptions
PRODUCT_COPY_FILES += \
    device/google/crosshatch/default-permissions.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default-permissions/default-permissions.xml

PRODUCT_PACKAGES += \
    fs_config_dirs \
    fs_config_files

# Context hub HAL
PRODUCT_PACKAGES += \
    android.hardware.contexthub@1.0-impl.generic \
    android.hardware.contexthub@1.0-service

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \

# Vibrator HAL
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.2-service.crosshatch \

# Thermal HAL
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.1-service.crosshatch \

#GNSS HAL
PRODUCT_PACKAGES += \
    libgps.utils \
    libgnss \
    liblocation_api \
    android.hardware.gnss@1.1-impl-qti \
    android.hardware.gnss@1.1-service-qti

# Wireless Charger HAL
PRODUCT_PACKAGES += \
    vendor.google.wireless_charger@1.0

# VR HAL
PRODUCT_PACKAGES += \
    android.hardware.vr@1.0-service.crosshatch \

ENABLE_VENDOR_RIL_SERVICE := true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config


HOSTAPD := hostapd
HOSTAPD += hostapd_cli
PRODUCT_PACKAGES += $(HOSTAPD)

WPA := wpa_supplicant.conf
WPA += wpa_supplicant_wcn.conf
WPA += wpa_supplicant
PRODUCT_PACKAGES += $(WPA)

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    wificond \
    wifilogd \
    libwpa_client

LIB_NL := libnl_2
PRODUCT_PACKAGES += $(LIB_NL)

# Factory OTA
PRODUCT_PACKAGES += \
    FactoryOta

# Audio effects
PRODUCT_PACKAGES += \
    libvolumelistener \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcomvoiceprocessingdescriptors \
    libqcompostprocbundle

PRODUCT_PACKAGES += \
    audio.primary.sdm845 \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    libaudio-resampler \
    audio.hearing_aid.default

PRODUCT_PACKAGES += \
    android.hardware.audio@4.0-impl:32 \
    android.hardware.audio.effect@4.0-impl:32 \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.1-impl \
    android.hardware.audio@2.0-service

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PACKAGES += \
    tinyplay \
    tinycap \
    tinymix \
    tinypcminfo \
    cplay
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio_policy_configuration_a2dp_offload_disabled.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_a2dp_offload_disabled.xml \
    $(LOCAL_PATH)/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/hearing_aid_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/hearing_aid_audio_policy_configuration.xml \

# audio hal tables
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml \
    $(LOCAL_PATH)/sound_trigger_mixer_paths_wcd9340.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths_wcd9340.xml \
    $(LOCAL_PATH)/graphite_ipc_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/graphite_ipc_platform_info.xml \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    $(LOCAL_PATH)/media_codecs_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2.xml \
    $(LOCAL_PATH)/media_codecs_performance_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_c2.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
    $(LOCAL_PATH)/media_codecs_google_c2_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml \

# no xaac codecs for now, so don't copy the media_codecs_google*audio.xml files at this time.

PRODUCT_PROPERTY_OVERRIDES += \
    audio.snd_card.open.retries=50

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/lowi.conf:$(TARGET_COPY_OUT_VENDOR)/etc/lowi.conf

# GPS configuration file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gps.conf

# GPS debug file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps_debug.conf:system/etc/gps_debug.conf

# Vendor seccomp policy files for media components:
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp_policy/codec2.vendor.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.vendor.ext.policy \
    $(LOCAL_PATH)/seccomp_policy/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# Subsystem ramdump
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.ssr.enable_ramdumps=1
endif

# Subsystem silent restart
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.ssr.restart_level=modem,slpi,adsp

# setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

PRODUCT_COPY_FILES += \
    device/google/crosshatch/fstab.hardware:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_PLATFORM) \
    device/google/crosshatch/fstab.persist:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.persist

# Use the default charger mode images
PRODUCT_PACKAGES += \
    charger_res_images

# b/36703476
# Set default log size on userdebug/eng build to 1M
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES += ro.logd.size=1M
endif

# Dumpstate HAL
PRODUCT_PACKAGES += \
    android.hardware.dumpstate@1.0-service.crosshatch

# Citadel
PRODUCT_PACKAGES += \
    citadeld \
    citadel_updater \
    android.hardware.authsecret@1.0-service.citadel \
    android.hardware.oemlock@1.0-service.citadel \
    android.hardware.weaver@1.0-service.citadel \
    android.hardware.keymaster@4.0-service.citadel \
    wait_for_strongbox

# Citadel debug stuff
PRODUCT_PACKAGES_DEBUG += \
    test_citadel

# Storage: for factory reset protection feature
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp

PRODUCT_PACKAGES += \
    vndk-sp

PRODUCT_ENFORCE_RRO_TARGETS := framework-res

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m

PRODUCT_COPY_FILES += \
    device/google/crosshatch/hidl/android.hidl.base@1.0.so-32:system/lib/android.hidl.base@1.0.so \
    device/google/crosshatch/hidl/android.hidl.base@1.0.so-64:system/lib64/android.hidl.base@1.0.so \
    device/google/crosshatch/hidl/android.hidl.base@1.0.so-32:vendor/lib/android.hidl.base@1.0.so \
    device/google/crosshatch/hidl/android.hidl.base@1.0.so-64:vendor/lib64/android.hidl.base@1.0.so \

PRODUCT_PACKAGES += \
    ipacm

#Set default CDMA subscription to RUIM
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_cdma_sub=0

# Set display color mode to Automatic by default
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.sf.color_saturation=1.0 \
    persist.sys.sf.native_mode=2

# Easel device feature
PRODUCT_COPY_FILES += \
    device/google/crosshatch/permissions/com.google.hardware.camera.easel_2018.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.google.hardware.camera.easel_2018.xml

# ConfirmationUI HAL
PRODUCT_PACKAGES += \
    android.hardware.confirmationui@1.0-service-crosshatch

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1-service.fpc

# Reliability reporting
PRODUCT_PACKAGES += \
    hardware.google.pixelstats@1.0-service \
    pixelstats-vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# DRV2624 Haptics Waveform
PRODUCT_COPY_FILES += \
    device/google/crosshatch/vibrator/drv2624/drv2624.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/drv2624.bin

# CS40L20 Haptics Waveform & Firmware
PRODUCT_COPY_FILES += \
    device/google/crosshatch/vibrator/cs40l20/cs40l20.wmfw:$(TARGET_COPY_OUT_VENDOR)/firmware/cs40l20.wmfw \
    device/google/crosshatch/vibrator/cs40l20/cs40l20.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/cs40l20.bin

PRODUCT_VENDOR_KERNEL_HEADERS := device/google/crosshatch/sdm845/kernel-headers

# Audio ACDB data
PRODUCT_COPY_FILES += \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/Bluetooth_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/General_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/Global_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/Handset_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/Hdmi_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/Headset_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/Speaker_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/Codec_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/Codec_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/Bluetooth_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/General_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/Global_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/Handset_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/Hdmi_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/Headset_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/Speaker_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/Codec_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/Codec_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/Bluetooth_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/General_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/Global_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/Handset_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/Hdmi_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/Headset_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/Speaker_cal.acdb \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/Codec_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/Codec_cal.acdb \
     device/google/crosshatch/acdbdata/adsp_avs_config.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/adsp_avs_config.acdb

# Audio ACDB workspace files for QACT
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_COPY_FILES += \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-snd-card/workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-snd-card/workspaceFile.qwsp \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-b1-snd-card/workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-b1-snd-card/workspaceFile.qwsp \
     device/google/crosshatch/acdbdata/OEM/sdm845-tavil-c1-snd-card/workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/OEM/sdm845-tavil-c1-snd-card/workspaceFile.qwsp
endif

# CS35L36 Speaker Tuning
PRODUCT_COPY_FILES += \
    device/google/crosshatch/audio/crus_sp_config_b1_rx.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/crus_sp_config_b1_rx.bin \
    device/google/crosshatch/audio/crus_sp_config_b1_tx.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/crus_sp_config_b1_tx.bin \
    device/google/crosshatch/audio/crus_sp_config_c1_rx.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/crus_sp_config_c1_rx.bin \
    device/google/crosshatch/audio/crus_sp_config_c1_tx.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/crus_sp_config_c1_tx.bin

# Keymaster configuration
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

# Enable modem logging
PRODUCT_PROPERTY_OVERRIDES += \
    ro.radio.log_loc="/data/vendor/modem_dump" \
    ro.radio.log_prefix="modem_log_"

# Enable modem logging for debug
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.modem.diag.mdlog=true \
    persist.vendor.sys.modem.diag.mdlog_br_num=5
else
endif

# Preopt SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUIGoogle

# Enable stats logging in LMKD
TARGET_LMKD_STATS_LOG := true
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.lmk.log_stats=true

TARGET_ENABLE_MEDIADRM_64 := true

# default usb oem functions
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
  PRODUCT_PROPERTY_OVERRIDES += \
      persist.vendor.usb.usbradio.config=diag
endif

# Early phase offset configuration for SurfaceFlinger (b/75985430)
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.early_phase_offset_ns=500000
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.early_app_phase_offset_ns=500000
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.early_gl_phase_offset_ns=3000000
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.early_gl_app_phase_offset_ns=15000000

# Do not skip init trigger by default
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    vendor.skip.init=0

# Increment the SVN for any official public releases
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.svn=2
