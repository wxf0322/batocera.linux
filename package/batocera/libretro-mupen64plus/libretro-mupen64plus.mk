################################################################################
#
# MUPEN64PLUS
#
################################################################################
LIBRETRO_MUPEN64PLUS_VERSION = d1451bbfc47d465b8ffaa3fb9b39935ee8d37037
LIBRETRO_MUPEN64PLUS_SITE = $(call github,libretro,mupen64plus-libretro,$(LIBRETRO_MUPEN64PLUS_VERSION))

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
       LIBRETRO_MUPEN64PLUS_DEPENDENCIES += rpi-userland
endif

LIBRETRO_MUPEN64PLUS_SUPP_OPT=

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI3),y)
       LIBRETRO_MUPEN64PLUS_PLATFORM=rpi3
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI2),y)
       LIBRETRO_MUPEN64PLUS_PLATFORM=rpi2
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_XU4),y)
       LIBRETRO_MUPEN64PLUS_PLATFORM=odroid-ODROID-XU3
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_C2),y)
       LIBRETRO_MUPEN64PLUS_SUPP_OPT=FORCE_GLES=1 ARCH=aarch64
       LIBRETRO_MUPEN64PLUS_PLATFORM=linux
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_S905),y)
       LIBRETRO_MUPEN64PLUS_SUPP_OPT=FORCE_GLES=1 ARCH=aarch64
       LIBRETRO_MUPEN64PLUS_PLATFORM=linux
else ifeq ($(BR2_x86_i586),y)
       LIBRETRO_MUPEN64PLUS_SUPP_OPT=ARCH=i586
       LIBRETRO_MUPEN64PLUS_PLATFORM=linux
else
       LIBRETRO_MUPEN64PLUS_PLATFORM=$(LIBRETRO_PLATFORM)
endif

define LIBRETRO_MUPEN64PLUS_BUILD_CMDS
       CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_MUPEN64PLUS_PLATFORM)" $(LIBRETRO_MUPEN64PLUS_SUPP_OPT)
endef

define LIBRETRO_MUPEN64PLUS_INSTALL_TARGET_CMDS
       $(INSTALL) -D $(@D)/mupen64plus_libretro.so \
               $(TARGET_DIR)/usr/lib/libretro/mupen64plus_libretro.so
endef

define MUPEN64PLUS_CROSS_FIXUP
       $(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/Makefile
       $(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/Makefile
endef

MUPEN64PLUS_PRE_CONFIGURE_HOOKS += MUPEN64PLUS_FIXUP

$(eval $(generic-package))
