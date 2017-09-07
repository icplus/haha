#
# Copyright (C) 2016-2017 PandoraBox Team
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ray_wan
PKG_VERSION:=1.0.1
PKG_RELEASE:=70
PKG_HASHCODE:=319036dac078968286d077e6f37864329ea282b7

PKG_MAINTAINER:=Kerwin <kerwinblaze@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=30. Lafite
    TITLE:=WAN Page for Lafite Theme by Ray Config
    DEPENDS:=+lafite-core +lafite-common_wan
endef

define Package/$(PKG_NAME)/description
    WAN Page for Lafite Theme by Ray Config
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
