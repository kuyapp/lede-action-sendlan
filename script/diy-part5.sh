#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的192.168.2.1修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把Openwrt/*修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/xiaomi/g' package/base-files/files/bin/config_generate

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings

# 修改banne文件（banne文件在根目录）（不要修改此行代码,怕弄的diy-lede.sh文件全失效,不需要的话前面加#，或者全行代码删除了）
#rm -rf ./package/base-files/files/etc/banne && cd .. && cp -f ./banner openwrt/package/base-files/files/etc/ && cd openwrt

# 更改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# push packages to package/lean

pushd package/lean

#add openwrt-packages kenzok8源
git clone --depth=1 https://github.com/kenzok8/openwrt-packages

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# Add dnsfilter
#git clone --depth=1 https://github.com/garypang13/luci-app-dnsfilter

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter

# Add luci-app-vssr
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add luci-app-onliner (need luci-app-nlbwmon)
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-adguardhome
#git clone --depth=1 https://github.com/SuLingGG/luci-app-adguardhome

# Add luci-app-diskman
git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-dockerman
#rm -rf ../lean/luci-app-docker
#git clone --depth=1 https://github.com/KFERMercer/luci-app-dockerman
#git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add luci-app-gowebdav
#git clone --depth=1 https://github.com/project-openwrt/openwrt-gowebdav

# Add luci-app-nat6-helper
git clone --depth=1 https://github.com/Ausaci/luci-app-nat6-helper

# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../lean/luci-theme-argon

# Add luci-theme-rosy
git clone --depth=1 -b openwrt-18.06 https://github.com/shiyu1314/luci-theme-rosy
rm -rf ../lean/luci-theme-rosy

# Add luci-theme-netgear
git clone --depth=1 https://github.com/i028/luci-theme-netgear
rm -rf ../lean/luci-theme-netgear

# Add tmate
git clone --depth=1 https://github.com/project-openwrt/openwrt-tmate

# Add subconverter
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add luci-udptools
#git clone --depth=1 https://github.com/zcy85611/openwrt-luci-kcp-udp

# Add luci-app-oled (R2S Only)
#git clone --depth=1 https://github.com/NateLol/luci-app-oled

# Add driver for rtl8821cu & rtl8812au-ac
#svn co https://github.com/project-openwrt/openwrt/branches/master/package/ctcgfw/rtl8812au-ac
#svn co https://github.com/project-openwrt/openwrt/branches/master/package/ctcgfw/rtl8821cu
#popd

# Add netdata
#rm -rf ../lean/netdata
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata

# luci-app-netdata
rm -rf ../lean/luci-app-netdata
git clone --depth=1 https://github.com/sirpdboy/luci-app-netdata

# Mod zzz-default-settings
#pushd package/lean/default-settings/files
#sed -i '/http/d' zzz-default-settings
#export orig_version="$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
#sed -i "s/${orig_version}/${orig_version} ($(date +"%Y-%m-%d"))/g" zzz-default-settings
#popd

# Fix libssh
#pushd feeds/packages/libs
#rm -rf libssh
#svn co https://github.com/openwrt/packages/trunk/libs/libssh
#popd

# Use Lienol's https-dns-proxy package
#pushd feeds/packages/net
#rm -rf https-dns-proxy
#svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy
#popd

# Use snapshots syncthing package
#pushd feeds/packages/utils
#rm -rf syncthing
#svn co https://github.com/openwrt/packages/trunk/utils/syncthing
#popd

# Fix mt76 wireless driver
#pushd package/kernel/mt76
#sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
#popd

# Add po2lmo
#git clone https://github.com/openwrt-dev/po2lmo.git
#pushd po2lmo
#make && sudo make install
#popd

#添加smartdns
git clone https://github.com/pymumu/openwrt-smartdns package/smartdns
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
