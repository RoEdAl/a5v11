#!/bin/bash

packages=( \
    -luci \
    -ppp -ppp-mod-pppoe \
    -odhcpd -odhcp6c \
    -ip6tables -kmod-ip6tables \
    iptables-mod-ipopt kmod-ipt-conntrack \
    kmod-ipt-ipset \
    -wpad-mini hostapd \
    igmpproxy \
    usb-modeswitch comgt-ncm \
    kmod-usb-net-huawei-cdc-ncm \
    block-mount kmod-usb-storage-extras \
    kmod-fs-ext4 \
    kmod-fs-vfat kmod-nls-cp437 kmod-nls-iso8859-1 \
    kmod-fs-exfat \
    kmod-usb-audio kmod-sound-core \
    kmod-usb-net-dm9601-ether kmod-usb-net-asix \
    http://downloads.openwrt.org/barrier_breaker/14.07/ramips/rt305x/packages/oldpackages/io_1_ramips_24kec.ipk )

make image PROFILE=A5-V11 PACKAGES="${packages[*]}" FILES=files/huawei_3g_lycamobile/
