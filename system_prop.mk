#
# System Properties for s2
#

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
	rild.libpath=/vendor/lib64/libril-qc-qmi-1.so \
	rild.libargs=-d /dev/smd0 \
	ro.telephony.default_network=9 \
	telephony.lteOnCdmaDevice=0 \
	telephony.lteOnGsmDevice=1 \
	persist.radio.multisim.config=dsds \
	persist.radio.calls.on.ims=0 \
	persist.radio.jbims=0 \
	persist.radio.csvt.enabled=false \
	persist.radio.rat_on=combine \
	persist.radio.mt_sms_ack=20

# NITZ
PRODUCT_PROPERTY_OVERRIDES += \
    persist.rild.nitz_plmn="" \
    persist.rild.nitz_long_ons_0="" \
    persist.rild.nitz_long_ons_1="" \
    persist.rild.nitz_long_ons_2="" \
    persist.rild.nitz_long_ons_3="" \
    persist.rild.nitz_short_ons_0="" \
    persist.rild.nitz_short_ons_1="" \
    persist.rild.nitz_short_ons_2="" \
	persist.rild.nitz_short_ons_3=""

# Factory Reset Protection
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/config

# system prop for opengles version
# 196609 is decimal for 0x30001 to report major/minor versions as 3/1
PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=196609 \
	sys.sf.lcd_density=420


