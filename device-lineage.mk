# EUICC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:system/etc/permissions/android.hardware.telephony.euicc.xml

# Overlays
DEVICE_PACKAGE_OVERLAYS += device/google/crosshatch/overlay-lineage

# RCS
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    PresencePolling \
    RcsService

# Snap Camera
PRODUCT_PACKAGES += \
    Snap

WITH_GMS_FI := true

PRODUCT_COPY_FILES += \
    device/google/bonito/permissions/privapp-permissions-aosp-extended.xml:system/etc/permissions/privapp-permissions-aosp-extended.xml
