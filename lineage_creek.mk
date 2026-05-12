#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common AOSP 64-bit phone config
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system.mk)

# Inherit from LineageOS common configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from creek device
$(call inherit-product, device/xiaomi/creek/device.mk)

# Basic identifiers
PRODUCT_NAME := lineage_creek
LINEAGE_BUILDTYPE := UNOFFICIAL
PRODUCT_DEVICE := creek
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := POCO
PRODUCT_MODEL := POCO M7 4G

# AudioFX
TARGET_EXCLUDES_AUDIOFX := true

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
