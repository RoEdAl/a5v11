#!/bin/bash

get_abs_dir() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)"
  fi
}

# retrieve the full pathname of the called script
SCRIPT_DIR=$(get_abs_dir $0)

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
    iwinfo
    igmpproxy
    usb-modeswitch comgt-ncm
    kmod-usb-net-huawei-cdc-ncm
    block-mount kmod-usb-storage-extras
    kmod-fs-ext4
    kmod-sound-core kmod-usb-audio
    kmod-usb-net-dm9601-ether kmod-usb-net-asix
    http://downloads.openwrt.org/barrier_breaker/14.07/ramips/rt305x/packages/oldpackages/io_1_ramips_24kec.ipk )

make image -C "$SCRIPT_DIR/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64" PROFILE=A5-V11 PACKAGES="${packages[*]}" FILES="$SCRIPT_DIR/huawei_3g_lycamobile/"
