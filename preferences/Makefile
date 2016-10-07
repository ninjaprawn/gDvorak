include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = gdvorak
gdvorak_INSTALL_PATH = /Library/PreferenceBundles

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/gdvorak.plist$(ECHO_END)
	$(ECHO_NOTHING)cp icon.png $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(ECHO_END)
	$(ECHO_NOTHING)cp icon@2x.png $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(ECHO_END)
	$(ECHO_NOTHING)cp icon@3x.png $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(ECHO_END)
