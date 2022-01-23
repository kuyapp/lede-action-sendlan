#!/bin/bash
#
# 修改openwrt登陆地址,把下面的192.168.2.1修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把E8820S修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/CMCC-A9/g' package/base-files/files/bin/config_generate

# 修改开源驱动wifi名称
sed -i 's/OpenWrt/ZCMCC-A9/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改闭源驱动2G wifi名称
#sed -i 's/OpenWrt_2G/ZTE-E8820S/g' package/lean/mt/drivers/mt_wifi/files/mt7603.dat

# 修改闭源驱动5G wifi名称
#sed -i 's/OpenWrt_5G/ZTE-E8820S-5G/g' package/lean/mt/drivers/mt_wifi/files/mt7612.dat

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings

# 修改banne文件（banne文件在根目录）（不要修改此行代码,怕弄的diy-lede.sh文件全失效,不需要的话前面加#，或者全行代码删除了）
#rm -rf ./package/base-files/files/etc/banne && cd .. && cp -f ./banner openwrt/package/base-files/files/etc/ && cd openwrt

# 更改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

