# OpenWRT mage builder helpers for A5-V11 router (CC 15.05)

[A5-V11 OpenWRT page](http://wiki.openwrt.org/toh/unbranded/a5-v11).

## Sharing Internet from Lycamobile (PL) provider using Huawei 3G/UMTS dongle.

* **ncm** mode  (```kmod-usb-net-huawei-cdc-ncm``` kernel module).

  ````
  config interface wan
	option proto ncm
	option device '/dev/cdc-wdm0'
  ````
  
  Tested with [Huawei E3131](http://consumer.huawei.com/en/mobile-broadband/dongles/features/e3131-en.htm) dongle.
  ID: ```12d1:14fe``` (```12d1:1506``` after [modeswitch](http://wiki.openwrt.org/doc/recipes/3gdongle#switching_usb_mode)).
  
   ```
   lsusb
   Bus 001 Device 005: ID 12d1:1506 Huawei Technologies Co., Ltd. E398 LTE/UMTS/GSM Modem/Networkcard
   ```
* No [**LuCI**](http://wiki.openwrt.org/doc/howto/luci.essentials).
* IPv6 disabled.
* iptables configured to enable Internet sharing from *Lycamobile* (PL) provider (TTL mangling).
* Two subnets:
  * 10.0.0.1/24 - ethernet, 12h lease time
  * 10.0.1.1/24 - wireless, 1h lease time
* [igmpproxy](http://wiki.openwrt.org/doc/howto/udp_multicast) configured (not enabled).
* AP configured (not enabled).
* [extroot](http://wiki.openwrt.org/doc/howto/extroot) ready.
 
### Installed packages.

```
root@A5V11:/tmp# opkg list-installed
base-files - 157-r46767
block-mount - 2015-05-24-09027fc86babc3986027a0e677aca1b6999a9e14
busybox - 1.23.2-1
chat - 2.4.7-6
comgt - 0.32-25
comgt-ncm - 0.32-25
dnsmasq - 2.73-1
dropbear - 2015.67-1
firewall - 2015-07-27
fstools - 2015-05-24-09027fc86babc3986027a0e677aca1b6999a9e14
hostapd - 2015-03-25-1
hostapd-common - 2015-03-25-1
igmpproxy - 0.1-8
io - 1
ip - 4.0.0-1
iptables - 1.4.21-1
iptables-mod-ipopt - 1.4.21-1
iptables-mod-tee - 1.4.21-1
iw - 3.17-1
jshn - 2015-06-14-d1c66ef1131d14f0ed197b368d03f71b964e45f8
jsonfilter - 2014-06-19-cdc760c58077f44fc40adbbe41e1556a67c1b9a9
kernel - 3.18.20-1-c8b57a131072a3198e594822481af3e0
kmod-cfg80211 - 3.18.20+2015-03-09-3
kmod-crypto-aes - 3.18.20-1
kmod-crypto-arc4 - 3.18.20-1
kmod-crypto-core - 3.18.20-1
kmod-crypto-hash - 3.18.20-1
kmod-dummy - 3.18.20-1
kmod-eeprom-93cx6 - 3.18.20-1
kmod-fs-ext4 - 3.18.20-1
kmod-fs-vfat - 3.18.20-1
kmod-gpio-button-hotplug - 3.18.20-1
kmod-input-core - 3.18.20-1
kmod-ipt-conntrack - 3.18.20-1
kmod-ipt-core - 3.18.20-1
kmod-ipt-ipopt - 3.18.20-1
kmod-ipt-ipset - 3.18.20-1
kmod-ipt-nat - 3.18.20-1
kmod-ipt-tee - 3.18.20-1
kmod-ipv6 - 3.18.20-1
kmod-leds-gpio - 3.18.20-1
kmod-lib-crc-ccitt - 3.18.20-1
kmod-lib-crc-itu-t - 3.18.20-1
kmod-lib-crc16 - 3.18.20-1
kmod-libphy - 3.18.20-1
kmod-mac80211 - 3.18.20+2015-03-09-3
kmod-mii - 3.18.20-1
kmod-nf-conntrack - 3.18.20-1
kmod-nf-ipt - 3.18.20-1
kmod-nf-nat - 3.18.20-1
kmod-nf-nathelper - 3.18.20-1
kmod-nfnetlink - 3.18.20-1
kmod-nls-base - 3.18.20-1
kmod-nls-cp437 - 3.18.20-1
kmod-nls-iso8859-1 - 3.18.20-1
kmod-rt2800-lib - 3.18.20+2015-03-09-3
kmod-rt2800-mmio - 3.18.20+2015-03-09-3
kmod-rt2800-soc - 3.18.20+2015-03-09-3
kmod-rt2x00-lib - 3.18.20+2015-03-09-3
kmod-rt2x00-mmio - 3.18.20+2015-03-09-3
kmod-sched - 3.18.20-1
kmod-sched-core - 3.18.20-1
kmod-scsi-core - 3.18.20-1
kmod-sound-core - 3.18.20-1
kmod-usb-audio - 3.18.20-1
kmod-usb-core - 3.18.20-1
kmod-usb-net - 3.18.20-1
kmod-usb-net-asix - 3.18.20-1
kmod-usb-net-cdc-ncm - 3.18.20-1
kmod-usb-net-dm9601-ether - 3.18.20-1
kmod-usb-net-huawei-cdc-ncm - 3.18.20-1
kmod-usb-ohci - 3.18.20-1
kmod-usb-storage - 3.18.20-1
kmod-usb-storage-extras - 3.18.20-1
kmod-usb-wdm - 3.18.20-1
kmod-usb2 - 3.18.20-1
libblobmsg-json - 2015-06-14-d1c66ef1131d14f0ed197b368d03f71b964e45f8
libc - 0.9.33.2-1
libgcc - 4.8-linaro-1
libip4tc - 1.4.21-1
libip6tc - 1.4.21-1
libjson-c - 0.12-1
libjson-script - 2015-06-14-d1c66ef1131d14f0ed197b368d03f71b964e45f8
libnl-tiny - 0.1-4
libpthread - 0.9.33.2-1
librt - 0.9.33.2-1
libubox - 2015-06-14-d1c66ef1131d14f0ed197b368d03f71b964e45f8
libubus - 2015-05-25-f361bfa5fcb2daadf3b160583ce665024f8d108e
libuci - 2015-04-09.1-1
libusb-1.0 - 1.0.19-1
libxtables - 1.4.21-1
mtd - 21
netifd - 2015-06-08-8795f9ef89626cd658f615c78c6a17e990c0dcaa
opkg - 9c97d5ecd795709c8584e972bfdf3aee3a5b846d-7
procd - 2015-08-16-0da5bf2ff222d1a499172a6e09507388676b5a08
swconfig - 10
tc - 4.0.0-1
ubox - 2015-07-14-907d046c8929fb74e5a3502a9498198695e62ad8
ubus - 2015-05-25-f361bfa5fcb2daadf3b160583ce665024f8d108e
ubusd - 2015-05-25-f361bfa5fcb2daadf3b160583ce665024f8d108e
uci - 2015-04-09.1-1
usb-modeswitch - 2014-08-26-993a9a542791953c4804f7ddbb3a07756738e37a
usign - 2015-05-08-cf8dcdb8a4e874c77f3e9a8e9b643e8c17b19131
wwan - 2014-07-17-1
```

# General build instrucitons.
1. Clone this repository.

   ```
   git clone --depth=1 https://github.com/RoEdAl/a5v11
   ```
1. Download OpenWRT [image builder](http://wiki.openwrt.org/doc/howto/obtain.firmware.generate) from [here](http://downloads.openwrt.org/chaos_calmer/15.05/ramips/rt305x/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2) and unapck it.

  ```
  cd a5v11
  wget http://downloads.openwrt.org/chaos_calmer/15.05/ramips/rt305x/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2
  tar -xjf OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2
  ```

1. Run ```build_...``` script. 

  ```
    ./build_huawei_3g_lycamobile.sh
  ```
1. [Flash router](http://wiki.openwrt.org/doc/howto/generic.flashing) with newly created image ```openwrt-15.05-ramips-rt305x-a5-v11-squashfs-factory.bin``` (or [```openwrt-15.05-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin```](http://wiki.openwrt.org/doc/howto/generic.sysupgrade)) located in ```OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64/bin/rampis``` subdirectory.
