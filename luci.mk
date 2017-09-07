#
# Copyright (C) 2008-2015 The LuCI Team <luci@lists.subsignal.org>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

LUCI_NAME?=$(notdir ${CURDIR})
LUCI_TYPE?=$(word 2,$(subst -, ,$(LUCI_NAME)))
LUCI_BASENAME?=$(patsubst luci-$(LUCI_TYPE)-%,%,$(LUCI_NAME))
LUCI_LANGUAGES:=$(filter-out templates,$(notdir $(wildcard ${CURDIR}/po/*)))
LUCI_DEFAULTS:=$(notdir $(wildcard ${CURDIR}/root/etc/uci-defaults/*))

# Submenu titles
LUCI_MENU.col=1. Collections
LUCI_MENU.mod=2. Modules
LUCI_MENU.app=3. Applications
LUCI_MENU.theme=4. Themes
LUCI_MENU.proto=5. Protocols
LUCI_MENU.lib=6. Libraries


PKG_NAME?=$(LUCI_NAME)

PKG_VERSION?=$(if $(DUMP),x,$(strip $(shell \
	if git log -1 >/dev/null 2>/dev/null; then \
		set -- $$(git log -1 --format="%ct %h"); \
		secs="$$(($$1 % 86400))"; \
		yday="$$(date --utc --date="@$$1" "+%y.%j")"; \
		revision="$$(printf 'git-%s.%05d-%s' "$$yday" "$$secs" "$$2")"; \
	else \
		revision="unknown"; \
	fi; \
	echo "$$revision" \
)))

PKG_RELEASE?=1
PKG_INSTALL:=$(if $(realpath src/Makefile),1)
PKG_BUILD_DEPENDS += lua/host luci-base/host $(LUCI_BUILD_DEPENDS)
PKG_CONFIG_DEPENDS += CONFIG_LUCI_SRCDIET

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=$(if $(LUCI_MENU.$(LUCI_TYPE)),$(LUCI_MENU.$(LUCI_TYPE)),$(LUCI_MENU.app))
  TITLE:=$(if $(LUCI_TITLE),$(LUCI_TITLE),LuCI $(LUCI_NAME) $(LUCI_TYPE))
  DEPENDS:=$(LUCI_DEPENDS)
  $(if $(LUCI_PKGARCH),PKGARCH:=$(LUCI_PKGARCH))
endef

ifneq ($(LUCI_DESCRIPTION),)
 define Package/$(PKG_NAME)/description
   $(strip $(LUCI_DESCRIPTION))
 endef
endif

define Build/Prepare
	for d in luasrc htdocs root src; do \
	  if [ -d ./$$$$d ]; then \
	    mkdir -p $(PKG_BUILD_DIR)/$$$$d; \
		$(CP) ./$$$$d/* $(PKG_BUILD_DIR)/$$$$d/; \
	  fi; \
	done
	$(call Build/Prepare/Default)
endef

define Build/Configure
endef

ifneq ($(wildcard ${CURDIR}/src/Makefile),)
 MAKE_PATH := src/
 MAKE_VARS += FPIC="$(FPIC)" LUCI_VERSION="$(PKG_VERSION)"

 define Build/Compile
	$(call Build/Compile/Default,clean compile)
 endef
else
 define Build/Compile
 endef
endif

HTDOCS = /www
LUA_LIBRARYDIR = /usr/lib/lua
LUCI_LIBRARYDIR = $(LUA_LIBRARYDIR)/luci

define PreCompile
	$(FIND) $(1) -type f -name '*.lua' | while read src; do \
		if $(STAGING_DIR_HOST)/bin/luac -s -o "$$$$src.o" "$$$$src"; \
		then mv "$$$$src.o" "$$$$src"; fi; \
	done
endef

define Package/$(PKG_NAME)/install
	if [ -d $(PKG_BUILD_DIR)/luasrc ]; then \
	  $(INSTALL_DIR) $(1)$(LUCI_LIBRARYDIR); \
	  cp -pR $(PKG_BUILD_DIR)/luasrc/* $(1)$(LUCI_LIBRARYDIR)/; \
	  $(FIND) $(1)$(LUCI_LIBRARYDIR)/ -type f -name '*.luadoc' | $(XARGS) rm; \
	  $(call PreCompile,$(1)$(LUCI_LIBRARYDIR)/); \
	else true; fi
	if [ -d $(PKG_BUILD_DIR)/htdocs ]; then \
	  $(INSTALL_DIR) $(1)$(HTDOCS); \
	  cp -pR $(PKG_BUILD_DIR)/htdocs/* $(1)$(HTDOCS)/; \
	else true; fi
	if [ -d $(PKG_BUILD_DIR)/root ]; then \
	  $(INSTALL_DIR) $(1)/; \
	  cp -pR $(PKG_BUILD_DIR)/root/* $(1)/; \
	else true; fi
	if [ -d $(PKG_BUILD_DIR)/src ]; then \
	  $(call Build/Install/Default) \
	  $(CP) $(PKG_INSTALL_DIR)/* $(1)/; \
	else true; fi
endef

ifneq ($(LUCI_DEFAULTS),)
define Package/$(PKG_NAME)/postinst
[ -n "$${IPKG_INSTROOT}" ] || {$(foreach script,$(LUCI_DEFAULTS),
	(. /etc/uci-defaults/$(script)) && rm -f /etc/uci-defaults/$(script))
	exit 0
}
endef
endif

LUCI_BUILD_PACKAGES := $(PKG_NAME)
$(foreach pkg,$(LUCI_BUILD_PACKAGES),$(eval $(call BuildPackage,$(pkg))))
