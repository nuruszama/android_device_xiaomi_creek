#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Add common definitions for Qualcomm
# $(call inherit-product, hardware/qcom-caf/common/common.mk)

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# APEX
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Ramdisk Security
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Enable virtual A/B compression
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/android_t_baseline.mk)
PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := lz4

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from the proprietary vendor version
$(call inherit-product, vendor/xiaomi/creek/creek-vendor.mk)

# Basic Android configs
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# A/B OTA config
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc

PRODUCT_PACKAGES += \
    checkpoint_gc \
    e2fsck.recovery \
    otapreopt_script

# Init scripts
PRODUCT_PACKAGES += \
    init.creek.rc \
    init.creek.hw.rc \
    init.target.rc \
    fstab.zram \
    fstab.default \
    init.vendor.sensors.rc \
    init.qti.display_boot.rc \
    init.qcom.rc \
    init.qti.kernel.rc \
    ueventd.qcom.rc

PRODUCT_PACKAGES += \
    init.class_main.sh \
    init.kernel.post_boot-bengal-iot.sh \
    init.kernel.post_boot-bengal.sh \
    init.kernel.post_boot.sh \
    init.qcom.class_core.sh \
    init.qcom.early_boot.sh \
    init.qcom.post_boot.sh \
    init.qcom.sh \
    init.qti.dcvs.sh \
    init.qti.early_init.sh \
    init.qti.kernel.sh \
    init.qti.write.sh \
    system_dlkm_modprobe.sh \
    vendor_modprobe.sh

# Copy the custom init scripts to the vendor image
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.creek.hw.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.creek.hw.rc \
    $(LOCAL_PATH)/rootdir/etc/init.creek.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.hw.rc

# Disable OpenMAX legacy media framework used in older Android versions
TARGET_SUPPORTS_OMX_SERVICE := false

# Fastbootd support for easier debugging
PRODUCT_PACKAGES += \
    android.hardware.fastboot-service.example_recovery \
    fastbootd
    
# VINTF & Compatibility
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Qualcomm Power Configurations
$(call inherit-product, vendor/qcom/opensource/power/power-vendor-product.mk)

# Qualcomm USB Configurations
$(call inherit-product, vendor/qcom/opensource/usb/vendor_product.mk)

# USB Permissions (AOSP)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# Qualcomm Vibrator Configurations
$(call inherit-product, vendor/qcom/opensource/vibrator/vibrator-vendor-product.mk)

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-V1-ndk.vendor \
    android.hardware.health@2.1.vendor

$(call inherit-product, vendor/qcom/opensource/healthd-ext/health-vendor-product.mk)
