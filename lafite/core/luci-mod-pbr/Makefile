#
# Copyright (C) 2016-2016 PandoraBox Team
#
# This is free software, and you can ask **Lintel** get the Lincense
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-mod-pbr
PKG_VERSION:=0.1.1
PKG_RELEASE:=2
PKG_MAINTAINER:=Arylo <arylo.open@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-mod-pbr
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=30. Lafite
    TITLE:=PB Core
    DEPENDS:=+luci-lib-json
endef

define Package/luci-mod-pbr/description
    PB Core Api
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-mod-pbr/install
    $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,luci-mod-pbr))
