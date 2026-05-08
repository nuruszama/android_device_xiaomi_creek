#
# Minimal Product Config for Boot Test (Creek)
#

# Inherit from creek device
$(call inherit-product, device/xiaomi/creek/device.mk)

# Inherit from LineageOS common configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Basic identifiers
PRODUCT_NAME := lineage_creek
LINEAGE_BUILDTYPE := UNOFFICIAL
PRODUCT_DEVICE := creek
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := POCO
PRODUCT_MODEL := POCO M7 4G

# Gapps config (disabled)
WITH_GMS := false
TARGET_SUPPORTS_GOOGLE_RECORDER := false
TARGET_INCLUDE_STOCK_ARCORE := false
TARGET_INCLUDE_GOOGLE_COMMS := false
TARGET_INCLUDE_PIXEL_LAUNCHER := false
TARGET_INCLUDE_LIVE_WALLPAPERS := false

# AudioFX
TARGET_EXCLUDES_AUDIOFX := true

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="creek_p_global-user 16 BP2A.250605.031.A3 OS3.0.10.0.WBOMIXM release-keys" \
    BuildFingerprint="POCO/creek_p_global/creek:16/BP2A.250605.031.A3/OS3.0.10.0.WBOMIXM:user/release-keys"