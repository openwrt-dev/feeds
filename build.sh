#!/bin/bash -e
set -o pipefail

SDK_DIR=/tmp/openwrt-sdk

get_sdk() {
  curl -sSL $SDK_URL | tar Jxf -
  mv openwrt-sdk-* $SDK_DIR
}

copy_sources() {
  mkdir -p $SDK_DIR/package/openwrt-dev
  cp -r libs net $SDK_DIR/package/openwrt-dev
  cp key-build $SDK_DIR
}

build_packages() {
  cd $SDK_DIR

  make defconfig V=s

  make package/libev/compile V=s
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
  make package/openwrt-shadowsocks/compile V=w
  make package/openwrt-simple-obfs/compile V=w

  make package/index V=s
}

get_sdk
copy_sources
build_packages
