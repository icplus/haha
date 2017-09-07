#
# Copyright (C) 2016-2017 PandoraBox Team
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lafite-ddns
PKG_VERSION:=1.0.1
PKG_RELEASE:=45
PKG_HASHCODE:=5291b36e35f1050de3ca0e1a15800ac9ff26917d

PKG_MAINTAINER:=Kerwin <kerwinblaze@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=30. Lafite
    TITLE:=DDNS Plugin for Lafite Theme
    DEPENDS:=+lafite-core +ddns-scripts
endef

define Package/$(PKG_NAME)/description
    DDNS Plugin for Lafite Theme
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
