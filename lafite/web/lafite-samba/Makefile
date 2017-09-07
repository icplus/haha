#
# Copyright (C) 2016-2017 PandoraBox Team
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lafite-samba
PKG_VERSION:=1.0.1
PKG_RELEASE:=46
PKG_HASHCODE:=e648d4487b543e52082754911327a1e9ec7b339c

PKG_MAINTAINER:=Arylo <arylo.open@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=30. Lafite
    TITLE:=Samba Plugin for Lafite Theme
    DEPENDS:=+lafite-core +samba3-pandorabox
endef

define Package/$(PKG_NAME)/description
    Samba Plugin for Lafite Theme
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
