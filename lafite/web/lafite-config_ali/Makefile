#
# Copyright (C) 2016-2017 PandoraBox Team
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lafite-config_ali
PKG_VERSION:=1.0.1
PKG_RELEASE:=1
PKG_HASHCODE:=285223afea2df93422a11a61673d7f907f169716

PKG_MAINTAINER:=Arylo <arylo.open@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=1. Collections
    TITLE:=Ali Config for Lafite Theme
    DEPENDS:=+uhttpd +uhttpd-mod-ubus \
        +luci-app-firewall +luci-proto-ppp +libiwinfo-lua +IPV6:luci-proto-ipv6 \
        +lafite-config_ray \
        +ray_auth \
        +ray_guide \
        +ray-overview +ray-network-status +ray-clientlist \
        +ray-modulestore \
        +ray-wireless_basic +ray-wireless_relay \
        +ray_storage_overview +lafite-samba \
        +lafite-iplist \
        +ray_wan +ray_lan +ray_security +lafite-about
endef

define Package/$(PKG_NAME)/description
    Ray Config for Lafite Theme
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
