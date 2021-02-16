#!/bin/bash -e
set -o pipefail

TARGET=$(cut -d '/' -f 7-8 <<< $SDK_URL | tr '/' '-')
echo $TARGET
SDK_DIR=openwrt-sdk-$TARGET

get_sdk() {
  curl -sSL $SDK_URL | tar Jxf -
  mv openwrt-sdk* $SDK_DIR
}

get_sources() {
  cd $SDK_DIR
  git clone https://github.com/openwrt-dev/feeds.git package/openwrt-dev -b master --single-branch --recurse-submodules -j4
  cp ../key-build .
  cd ..
}

build_packages() {
  cd $SDK_DIR

  make defconfig

  make package/libev/compile V=w
  make package/libcares/compile V=w
  make package/libsodium/compile V=w
  make package/mbedtls/compile V=w
  make package/pcre/compile V=w

  make package/luci-app-shadowsocks/compile V=w
  make package/openwrt-dist-luci/compile V=w

  make package/openwrt-chinadns/compile V=w
  make package/openwrt-chinadns-ng/compile V=w
  make package/openwrt-dns-forwarder/compile V=w
  make package/openwrt-dns2tcp/compile V=w
  make package/openwrt-ipt2socks/compile V=w
  make package/openwrt-hev-socks5-server/compile V=w
  make package/openwrt-udp2raw/compile V=w
  make package/openwrt-udpspeeder/compile V=w
  make package/openwrt-dns2socks/compile V=w
  make package/openwrt-portfwd/compile V=w
  make package/openwrt-vlmcsd/compile V=w

  make package/openwrt-shadowsocks/compile V=w \
    CONFIG_SHADOWSOCKS_STATIC_LINK=y \
    CONFIG_SHADOWSOCKS_WITH_EV=y \
    CONFIG_SHADOWSOCKS_WITH_PCRE=y \
    CONFIG_SHADOWSOCKS_WITH_CARES=y \
    CONFIG_SHADOWSOCKS_WITH_SODIUM=y \
    CONFIG_SHADOWSOCKS_WITH_MBEDTLS=y

  make package/openwrt-simple-obfs/compile V=w \
    CONFIG_SIMPLE_OBFS_STATIC_LINK=y

  make package/index V=s

  cd ..
}

copy_binaries() {
  mkdir $TARGET
  cp -r $SDK_DIR/bin/packages/*/base $TARGET
}

get_sdk
get_sources
build_packages
copy_binaries
