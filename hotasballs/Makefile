ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = HotAsBalls
HotAsBalls_FILES = HABRootListController.m
HotAsBalls_INSTALL_PATH = /Library/PreferenceBundles
HotAsBalls_FRAMEWORKS = UIKit
HotAsBalls_PRIVATE_FRAMEWORKS = Preferences
HotAsBalls_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/HotAsBalls.plist$(ECHO_END)
