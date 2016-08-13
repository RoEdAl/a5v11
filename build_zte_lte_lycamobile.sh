#!/bin/bash

ImageBuilderDir=/OpenWrt-ImageBuilder-15.05.1-ramips-rt305x.Linux-x86_64

get_abs_dir() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)"
  fi
}

# retrieve the full pathname of the called script
SCRIPT_DIR=$(get_abs_dir $0)

if [ ! -d "$SCRIPT_DIR/$ImageBuilderDir" ]; then
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
    uqmi
    kmod-usb-serial kmod-usb-serial-option
    usb-modeswitch
    comgt
    block-mount kmod-usb-storage-extras
    kmod-fs-ext4
    kmod-sound-core kmod-usb-audio
    kmod-usb-net-asix
    http://dl.eko.one.pl/chaos_calmer/ramips/packages/3ginfo-text_20160623_all.ipk )

make image -C "$SCRIPT_DIR/$ImageBuilderDir" PROFILE=A5-V11 PACKAGES="${packages[*]}" FILES="$SCRIPT_DIR/zte_lte_lycamobile/" BIN_DIR="$SCRIPT_DIR/zte_lte_lycamobile.bin"
