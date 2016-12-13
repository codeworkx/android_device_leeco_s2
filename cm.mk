# Boot animation
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920

# Inherit device configuration
$(call inherit-product, device/letv/s2/full_s2.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := s2
PRODUCT_NAME := cm_s2
PRODUCT_BRAND := letv
PRODUCT_MODEL := s2
PRODUCT_MANUFACTURER := letv

PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT="LeEco/Le2_CN/le_s2:6.0.1/IEXCNFN5801809291S/63:user/release-keys" \
    PRIVATE_BUILD_DESC="s2-user 6.0.1 IEXCNFN5801809291S 63 release-keys"
