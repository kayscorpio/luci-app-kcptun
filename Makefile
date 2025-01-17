#
# Copyright 2016-2020 Xingwang Liao <kuoruan@gmail.com>
# Licensed to the public under the Apache License 2.0.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-kcptun
PKG_VERSION:=1.5.4
PKG_RELEASE:=1

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=Xingwang Liao <kuoruan@gmail.com>

LUCI_TITLE:=LuCI support for Kcptun
LUCI_DEPENDS:=+jshn +iptables +iptables-mod-tproxy
LUCI_PKGARCH:=all

define Package/$(PKG_NAME)/conffiles
/etc/config/kcptun_luci
endef

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/40_luci-kcptun ) && rm -f /etc/uci-defaults/40_luci-kcptun
fi

chmod 755 "$${IPKG_INSTROOT}/etc/init.d/kcptun_luci" >/dev/null 2>&1
ln -sf "../init.d/kcptun_luci" \
	"$${IPKG_INSTROOT}/etc/rc.d/S99kcptun_luci" >/dev/null 2>&1
exit 0
endef

# call BuildPackage - OpenWrt buildroot signature
