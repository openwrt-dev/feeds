#!/bin/bash -e

. $(dirname "$0")/func.sh

download_sdk() {
  curl -sSL $SDK_URL | tar Jxf -
  mv openwrt-sdk-* $SDK_DIR
}

get_sources() {
  cd $SDK_DIR

  # fullconenat
  install_feeds_with_patches package/feeds/base/firewall/
  install_feeds_with_patches package/feeds/luci/luci-app-firewall/

  # install package depends
  install_feeds_with_patches package/feeds/base/mbedtls/
  install_feeds c-ares libev libsodium pcre

  # copy sources
  cp -rv $CUR_DIR/net/* package/
  cp -rv $CUR_DIR/luci/* package/
  cp $CUR_DIR/key-build .

  cd $CUR_DIR
}

build_packages() {
  cd $SDK_DIR

  make defconfig

  build_package openwrt-chinadns
  build_package openwrt-chinadns-ng
  build_package openwrt-dns-forwarder
  build_package openwrt-dns2tcp
  build_package openwrt-ipt2socks
  build_package openwrt-portfwd
  build_package openwrt-vlmcsd
  build_package openwrt-transproxy

  build_package openwrt-shadowsocks
  build_package openwrt-simple-obfs
  build_package openwrt-v2ray-plugin
  build_package openwrt-xray-plugin
  build_package luci-app-shadowsocks
  build_package openwrt-dist-luci

  build_package openwrt-fullconenat
  build_package firewall
  build_package luci-app-firewall

  # remove useless & create index
  find bin/ -type f $(printf " ! -name %s_*" $(cat $CUR_DIR/packages.txt | trim_lines)) | xargs rm -f
  make package/index V=s

  cd $CUR_DIR
}

copy_packages() {
  cp -rv $SDK_DIR/bin/packages/*/base $IPK_ARCH-base
  cp -rv $SDK_DIR/bin/targets/${IPK_ARCH%%-*}/${IPK_ARCH##*-}/packages $IPK_ARCH-core
  cp -rv $SDK_DIR/bin/packages/*/luci $IPK_ARCH-luci
  cp -rv $SDK_DIR/bin/packages/*/packages $IPK_ARCH-packages
}

download_sdk
get_sources
build_packages
copy_packages
