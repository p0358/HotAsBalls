INSTALL_TARGET_PROCESSES = Weather
ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HotAsBalls
HotAsBalls_FILES = Tweak.xm
HotAsBalls_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
	
SUBPROJECTS += hotasballs
include $(THEOS_MAKE_PATH)/aggregate.mk
