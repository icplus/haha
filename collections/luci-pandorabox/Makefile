#
# Copyright (C) 2016 PandoraBox Team
#

include $(TOPDIR)/rules.mk
LUCI_TYPE:=col
LUCI_BASENAME:=luci-pandorabox
LUCI_TITLE:=Standard OpenWrt set including full admin with ppp support and the default Bootstrap theme
LUCI_DEPENDS:= \
	+uhttpd +uhttpd-mod-ubus +luci-mod-admin-full +luci-mod-pandorabox +luci-theme-lafite \
	+luci-app-firewall +luci-proto-ppp +libiwinfo-lua +IPV6:luci-proto-ipv6
include ../../luci.mk
# call BuildPackage - OpenWrt buildroot signature
