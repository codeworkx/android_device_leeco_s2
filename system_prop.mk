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

# Factory Reset Protection
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/config
