# LEDE image builders for A5-V11 router (17.01.1)

* [A5-V11 router - OpenWRT](http://wiki.openwrt.org/toh/unbranded/a5-v11).
* [A5-V11 router - LEDE](http://lede-project.org/toh/hwdata/other/other_a5-v11)

# Profiles:

## `huawei_3g_lycamobile` - sharing Internet from Lycamobile (PL) provider using Huawei 3G/UMTS dongle (not maintained anymore).

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
* No [**opkg**](http://wiki.openwrt.org/doc/techref/opkg).
* IPv6 disabled.
* iptables configured to enable Internet sharing from *Lycamobile* (PL) provider (TTL mangling).

  ````
  iptables -t mangle -I POSTROUTING -o wwan0 -j TTL --ttl-inc 1
  iptables -t mangle -I FORWARD -i wwan0 -j TTL --ttl-inc 1
  iptables -t mangle -I PREROUTING -i wwan0 -j TTL --ttl-inc 1
  ````
* Two subnets:
  * 10.0.0.1/24 - ethernet, 12h lease time
  * 10.0.1.1/24 - wireless, 1h lease time
* [igmpproxy](http://wiki.openwrt.org/doc/howto/udp_multicast) configured and invoked by [hotplug hook](http://dev.openwrt.org/ticket/20443).
* AP configured (not enabled).

## `zte_lte_lycamobile` - Sharing Internet from Lycamobile (PL) provider using ZTE MF821 USB dongle

* **qmi** mode.

  ````
  config interface wan
        option proto qmi
        option device '/dev/cdc-wdm0'
        option apn 'data.lycamobile.pl'
        option username lmpl
        option password plus
  ````
* No [**LuCI**](http://wiki.openwrt.org/doc/howto/luci.essentials).
* No [**opkg**](http://wiki.openwrt.org/doc/techref/opkg).
* IPv6 disabled.
* iptables configured to enable Internet sharing from Lycamobile (PL) provider (TTL mangling).

  ````
  iptables -t mangle -I POSTROUTING -o wwan0 -j TTL --ttl-inc 1
  iptables -t mangle -I FORWARD -i wwan0 -j TTL --ttl-inc 1
  iptables -t mangle -I PREROUTING -i wwan0 -j TTL --ttl-inc 1
  ````
* Two subnets:
  * 10.0.0.1/24 - ethernet, 12h lease time
  * 10.0.1.1/24 - wireless, 1h lease time
* [igmpproxy](http://wiki.openwrt.org/doc/howto/udp_multicast) configured and invoked by [hotplug hook](http://dev.openwrt.org/ticket/20443).
* AP configured (not enabled).

## `wireless_to_wired` - WiFi to Ethernet bridge using [relayd](https://wiki.openwrt.org/doc/uci/network#protocol_relay_relayd_pseudo_bridge) pseudo bridge.

* AP Subnet - 192.168.1.0/24, gateway 192.168.1.254.
* Client Subnet - 10.0.0.0/24, static address 10.0.0.1.
* No [**opkg**](http://wiki.openwrt.org/doc/techref/opkg).
* [igmpproxy](http://wiki.openwrt.org/doc/howto/udp_multicast) configured and invoked by [hotplug hook](http://dev.openwrt.org/ticket/20443).
* USB-Ethernet gadget support (Raspberry Pi Zero for example).

See also:

* [Routed Client with relayd (Pseudobridge)](http://wiki.openwrt.org/doc/recipes/relayclient).
* [Configuring an OpenWRT Router as a repeater for a FRITZ!Box with working Multicast](http://juliank.wordpress.com/2014/08/07/configuring-an-openwrt-router-as-a-repeater-for-a-fritzbox-with-working-multicast).
* [RASPBERRY PI ZERO – PROGRAMMING OVER USB!](http://blog.gbaman.info/?p=699).
    * [Setting up Pi Zero OTG - The quick way](http://gist.github.com/gbaman/975e2db164b3ca2b51ae11e45e8fd40a).
    * [Raspberry Pi Zero OTG Mode](http://gist.github.com/gbaman/50b6cca61dd1c3f88f41).
* [OpenWRT ticket #20443 - igmpproxy will not start at boot up](http://dev.openwrt.org/ticket/20443)


# General build instrucitons.
1. Clone this repository.

   ```
   git clone https://github.com/RoEdAl/a5v11
   ```
1. Download LEDE [image builder](http://lede-project.org/docs/user-guide/imagebuilder) from 
   [here](http://downloads.lede-project.org/releases/17.01.1/targets/ramips/rt305x/lede-imagebuilder-17.01.1-ramips-rt305x.Linux-x86_64.tar.xz) and unapck it.

  ```
  cd a5v11
  wget http://downloads.lede-project.org/releases/17.01.1/targets/ramips/rt305x/lede-imagebuilder-17.01.1-ramips-rt305x.Linux-x86_64.tar.xz
  tar -xvf lede-imagebuilder-17.01.1-ramips-rt305x.Linux-x86_64.tar.xz
  ```
1. Run proper ```build_…``` script. 

  ```
    ./build_huawei_3g_lycamobile.sh
  ```
1. [Flash router](http://wiki.openwrt.org/doc/howto/generic.flashing) with newly created image
   ```lede-17.01.1-ramips-rt305x-a5-v11-squashfs-factory.bin``` (or 
[```lede-17.01.0-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin```](http://wiki.openwrt.org/doc/howto/generic.sysupgrade))
   from proper  ```….lede-bin``` (e. g. ```huawei_3g_lycamobile.lede-bin```) subdirectory.

