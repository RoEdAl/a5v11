#!/bin/bash

# retrieve the full pathname of the called script
scriptPath=$(which $0)

# check whether the path is a link or not
if [ -L $scriptPath ]; then

    # it is a link then retrieve the target path and get the directory name
    SCRIPT_DIR=$(dirname $(readlink -f $scriptPath))

else

    # otherwise just get the directory name of the script path
    SCRIPT_DIR=$(dirname $scriptPath)

fi

if [ ! -d "$SCRIPT_DIR/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64" ]; then
    echo "Please install and extract OpenWRT image builder for rampis-rt305x"
    exit 1
fi

packages=( 
    -luci
    -ppp -ppp-mod-pppoe
    -odhcpd -odhcp6c
    -ip6tables -kmod-ip6tables
    kmod-dummy
    iptables-mod-ipopt
    kmod-ipt-conntrack
    kmod-ipt-tee kmod-ipt-ipset
    kmod-sched-core
    wpad-mini
    igmpproxy
    usb-modeswitch comgt-ncm
    kmod-usb-net-huawei-cdc-ncm
    block-mount kmod-usb-storage-extras
    kmod-fs-ext4
    kmod-sound-core kmod-usb-audio
    kmod-usb-net-dm9601-ether kmod-usb-net-asix
    http://downloads.openwrt.org/barrier_breaker/14.07/ramips/rt305x/packages/oldpackages/io_1_ramips_24kec.ipk )

make image -C "$SCRIPT_DIR/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64" PROFILE=A5-V11 PACKAGES="${packages[*]}" FILES="$SCRIPT_DIR/huawei_3g_lycamobile/"
