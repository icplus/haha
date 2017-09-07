#
# Copyright (C) 2016 PandoraBox Team
#

include $(TOPDIR)/rules.mk
LUCI_TYPE:=col
LUCI_BASENAME:=luci-ray
LUCI_TITLE:=Lafite Theme By Ray Edition
LUCI_DEPENDS:= \
	+uhttpd +uhttpd-mod-ubus \
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
include ../../luci.mk
# call BuildPackage - OpenWrt buildroot signature
