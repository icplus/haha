#
# Copyright (C) 2016-2017 PandoraBox Team
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ray-overview
PKG_VERSION:=1.0.1
PKG_RELEASE:=75
PKG_HASHCODE:=eca0b9b3e37001c8e4d897659e1af9578a57aa39

PKG_MAINTAINER:=AryloYeung <arylo.open@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=30. Lafite
    TITLE:=Overview Route Status Plugin for Lafite Theme by Ray Config
    DEPENDS:=+lafite-core +lafite-common_clientlist +lafite-common_bandwidth +ray-wireless_basic +usb_device_info
endef

define Package/$(PKG_NAME)/description
    Overview Route Status Plugin for Lafite Them by Ray Confige
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
