#!/bin/bash -e

. $(dirname "$0")/func.sh

download_sdk() {
  curl -sSL $SDK_URL | tar Jxf -
  mv openwrt-sdk-* $SDK_DIR
}

get_sources() {
  cd $SDK_DIR

  # install depends
  install_feeds libxtables

  # copy sources
  cp -rv $CUR_DIR/net/* package/
  cp $CUR_DIR/key-build .

  cd $CUR_DIR
}

build_packages() {
  cd $SDK_DIR

  make defconfig

  # some packages cannot compile with ccache, like openwrt-vlmcsd.
  sed -i 's/^CONFIG_CCACHE=y/# CONFIG_CCACHE is not set/' .config

  build_package openwrt-chinadns-ng
  build_package openwrt-dns-forwarder
  build_package openwrt-dns2tcp
  build_package openwrt-ipt2socks
  build_package openwrt-portfwd
  build_package openwrt-vlmcsd
  build_package openwrt-transproxy
  build_package openwrt-fullconenat

  # remove useless & create index
  find bin/ -type f $(printf " ! -name %s_*" $(cat $CUR_DIR/packages.txt | trim_lines)) | xargs rm -f
  make package/index V=s

  cd $CUR_DIR
}

copy_packages() {
  cp -rv $SDK_DIR/bin/packages/*/base $IPK_ARCH-base
  cp -rv $SDK_DIR/bin/targets/${IPK_ARCH%%-*}/${IPK_ARCH##*-}/packages $IPK_ARCH-core
}

download_sdk
get_sources
build_packages
copy_packages
