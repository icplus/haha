#
# Copyright (C) 2016-2017 PandoraBox Team
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lafite-core
PKG_VERSION:=1.0.1
PKG_RELEASE:=108
PKG_HASHCODE:=4145b828a0dba40452c158bc73f262f63a810a44

PKG_MAINTAINER:=Arylo <arylo.open@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=30. Lafite
    TITLE:=Core for Lafite Theme
    DEPENDS:=+luci-base +luci +luci-mod-pbr
endef

define Package/$(PKG_NAME)/description
    Lafite Theme Core Module
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
