#
# Copyright (C) 2016-2017 PandoraBox Team
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ray_guide
PKG_VERSION:=1.0.1
PKG_RELEASE:=73
PKG_HASHCODE:=a9e2deaca89a2164b6eb6907dbd2cbae0044e708

PKG_MAINTAINER:=Arylo <arylo.open@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=30. Lafite
    TITLE:=Guide Plugin for Lafite Theme by Ray Config
    DEPENDS:=+lafite-core +lafite-common_wan +lafite-config_ray +ppp-mod-pppoe
endef

define Package/$(PKG_NAME)/description
    Guide Plugin for Lafite Theme by Ray Config
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
    $(CP) ./files/* $(1)/
endef

define Package/$(PKG_NAME)/postinst
    [ -n "$${IPKG_INSTROOT}" ] || {
        (. /etc/pbr-defaults/$(PKG_NAME)/postinst) && \
        rm -rf /etc/pbr-defaults/$(PKG_NAME)
        exit 0
    }
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
