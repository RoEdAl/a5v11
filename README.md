# OpenWRT mage builder helpers for A5-V11 router (CC 15.05)

[A5-V11 OpenWRT page](http://wiki.openwrt.org/toh/unbranded/a5-v11).

## Huawei dongle with Lycamobile network support

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
* No *luci*.
* IPv6 disabled.
* **iptables** configured to work with *Lycamobile* (PL) network (TTL mangling).
* AP configured, not enabled by default.

# General build instrucitons.

* Download OpenWRT [image builder](http://wiki.openwrt.org/doc/howto/obtain.firmware.generate) from [here](http://downloads.openwrt.org/chaos_calmer/15.05/ramips/rt305x/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2).

  ```
  wget http://downloads.openwrt.org/chaos_calmer/15.05/ramips/rt305x/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2
  ```
* Unpack package.

  ```
  tar -xjf OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2
  ```

* Clone this repository.

   ```
   git clone https://github.com/RoEdAl/a5v11
   ```
   
* Copy files from cloned repository to ```OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64``` directory.
* Run ```build_...``` script within ```OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64``` directory. 

  ```
  cd OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64
  ./build_huawei_3g_lycamobile.sh
  ```
* [Flash router](http://wiki.openwrt.org/doc/howto/generic.flashing) with newly created image ```openwrt-15.05-ramips-rt305x-a5-v11-squashfs-factory.bin``` (or [```openwrt-15.05-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin```](http://wiki.openwrt.org/doc/howto/generic.sysupgrade)) located in ```bin/rampis``` subdirectory.
