#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Enable virtual AB with vendor ramdisk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Inherit from the proprietary vendor version
$(call inherit-product, vendor/xiaomi/creek/creek-vendor.mk)

# Disable OpenMAX legacy media framework used in older Android versions
TARGET_SUPPORTS_OMX_SERVICE := false

# DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay

PRODUCT_SOONG_NAMESPACES += \
    hardware/qcom-caf/common \
    hardware/qcom-caf/sm6225

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# A/B Partition Post-install
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# Audio - Basic Bengal HAL (Minimal)
$(call soong_config_set, android_hardware_audio, run_64bit, "true")

PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    audio.primary.bengal \
    android.hardware.audio@7.0-impl \
    android.hardware.audio@7.0-service \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.soundtrigger@2.3-impl

# Multimedia Sync
PRODUCT_PACKAGES += \
    libmm-omxcore \
    libOmxCore \
    libstagefrighthw \
    libOmxVdec \
    libOmxVenc

# Graphics & Display
PRODUCT_PACKAGES += \
    libgui_vendor \
    libgralloctypes\
    android.hardware.graphics.mapper@4.0-impl.qti \
    android.hardware.graphics.allocator@4.0-service \
    vendor.qti.hardware.display.composer-service \
    vendor.qti.hardware.display.mapper@4.0.vendor

# Graphics & Rendering
PRODUCT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.has_wide_color_display=true \
    ro.surface_flinger.disable_ext_vsync_event=1 \
    ro.surface_flinger.has_HDR_display=true \
    ro.surface_flinger.max_frame_buffer_acquired_buffers=3 \
    ro.surface_flinger.use_color_management=true \
    vendor.display.enable_display_extensions=1 \
    vendor.display.enable_async_powermode=1

# Neural Networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3.vendor
    
# Boot Control (UFS/BSG)
$(call soong_config_set, ufsbsg, ufsframework, bsg)

# Power & Health (Matches lshal and logcat thermal events)
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.power-service.pixel \
    android.hardware.thermal-service.qti

# Sensors (Matches lshal @2.1-service.multihal)
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.multihal

# Vibrator (Matches services.txt #309)
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.example # or the specific QTI one if available

# Xiaomi Hardware Services
PRODUCT_PACKAGES += \
    vendor.xiaomi.hardware.misys@3.0.vendor \
    vendor.xiaomi.hardware.micharge@1.0.vendor \
    vendor.xiaomi.hardware.displayfeature@1.0.vendor

# Telephony / RIL
PRODUCT_PACKAGES += \
    android.hardware.radio@1.6.vendor \
    android.hardware.radio.config@1.3.vendor \
    android.hardware.radio.deprecated@1.0.vendor \
    libxml2

# Telephony / Connectivity (Enhanced)
PRODUCT_PACKAGES += \
    android.hardware.radio.common.vendor \
    vendor.qti.hardware.radio.am@1.0.vendor \
    vendor.qti.hardware.radio.ims@1.0.vendor \
    vendor.qti.hardware.radio.qcrilhook@1.0.vendor

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1.vendor \
    android.hardware.bluetooth.audio-impl \
    vendor.qti.hardware.bluetooth_audio@2.1.vendor

# WiFi Symqlinks
PRODUCT_PACKAGES += \
    firmware_wlan_mac.bin_symlink \
    firmware_WCNSS_qcom_cfg.ini_symlink \
    firmware_wlanmdsp.mbn_symlink

# RPC Services (Required by many Qualcomm HALs to talk to the DSP)
PRODUCT_PACKAGES += \
    adsprpcd \
    cdsprpcd \
    audioadsprpcd
