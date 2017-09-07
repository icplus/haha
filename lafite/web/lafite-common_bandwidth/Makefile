#
# Copyright (C) 2016-2017 PandoraBox Team
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lafite-common_bandwidth
PKG_VERSION:=1.0.1
PKG_RELEASE:=1
PKG_HASHCODE:=3e0cb723001e50ecaf9340b84e4ed97e9bafd643

PKG_MAINTAINER:=AryloYeung <arylo.open@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=30. Lafite
    TITLE:=bandwidth common
    DEPENDS:=+lafite-core
endef

define Package/$(PKG_NAME)/description
    bandwidth common
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
