#
# Copyright (C) 2016-2016 PandoraBox Team
#
# This is free software, and you can ask **Lintel** get the Lincense
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pb-core
PKG_VERSION:=0.1.2
PKG_RELEASE:=3
PKG_MAINTAINER:=Arylo <arylo.open@gmail.com>

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/pb-core
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=3. Applications
    TITLE:=PB Core
    DEPENDS:=+luci-lib-json
endef

define Package/pb-core/description
    PB Core Api
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/pb-core/install
    $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,pb-core))
