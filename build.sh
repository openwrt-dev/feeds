#!/bin/bash -e
set -o pipefail
[ "$DEBUG" == 1 ] && set -x

CUR_DIR=$(pwd)
SDK_DIR=$(pwd)/openwrt-sdk

download_sdk() {
  curl -sSL $SDK_URL | tar Jxf -
  mv openwrt-sdk-* $SDK_DIR
}

get_sources() {
  cp -r libs/* net/* $SDK_DIR/package/
  cp key-build $SDK_DIR

  curl -sSL https://github.com/openwrt/openwrt/archive/v19.07.7.tar.gz | \
    tar -zxf - -C $SDK_DIR/package/ openwrt-19.07.7/package/network/utils/iptables --strip-components 4
}

update_config() {
  cd $SDK_DIR

  make defconfig

  # exclude packages
  sed -i 's/CONFIG_PACKAGE_mbedtls-util=m/# CONFIG_PACKAGE_mbedtls-util is not set/' .config
  sed -i 's/CONFIG_PACKAGE_luci-app-shadowsocks-without-ipset=m/# CONFIG_PACKAGE_luci-app-shadowsocks-without-ipset is not set/' .config

  # fix pcre compile
  sed -i 's/CONFIG_PACKAGE_libpcre16=m/# CONFIG_PACKAGE_libpcre16 is not set/' .config
  sed -i 's/CONFIG_PACKAGE_libpcre32=m/# CONFIG_PACKAGE_libpcre32 is not set/' .config
  sed -i 's/CONFIG_PACKAGE_libpcrecpp=m/# CONFIG_PACKAGE_libpcrecpp is not set/' .config

  cd $CUR_DIR
}

build_packages() {
  cd $SDK_DIR

  make -j$(nproc) package/c-ares/compile V=w
  make -j$(nproc) package/libev/compile V=w
  make -j$(nproc) package/libsodium/compile V=w
  make -j$(nproc) package/mbedtls/compile V=w
  make -j$(nproc) package/pcre/compile V=w

  make -j$(nproc) package/luci-app-shadowsocks/compile V=w
  make -j$(nproc) package/openwrt-dist-luci/compile V=w

  make -j$(nproc) package/openwrt-chinadns/compile V=w
  make -j$(nproc) package/openwrt-chinadns-ng/compile V=w
  make -j$(nproc) package/openwrt-dns-forwarder/compile V=w
  make -j$(nproc) package/openwrt-dns2tcp/compile V=w
  make -j$(nproc) package/openwrt-hev-socks5-server/compile V=w
  make -j$(nproc) package/openwrt-ipt2socks/compile V=w
  make -j$(nproc) package/openwrt-portfwd/compile V=w
  make -j$(nproc) package/openwrt-shadowsocks/compile V=w
  make -j$(nproc) package/openwrt-simple-obfs/compile V=w
  make -j$(nproc) package/openwrt-udp2raw/compile V=w
  make -j$(nproc) package/openwrt-udpspeeder/compile V=w
  make -j$(nproc) package/openwrt-vlmcsd/compile V=w

  make -j$(nproc) package/openwrt-fullconenat/compile V=w

  cd $CUR_DIR
}

remove_useless() {
  cd $SDK_DIR
  find bin/targets -type f ! -name "kmod-ipt-fullconenat*" | xargs rm -f
  cd $CUR_DIR
}

create_index() {
  cd $SDK_DIR
  make package/index V=s
  cd $CUR_DIR
}

copy_packages() {
  cp -r $SDK_DIR/bin/packages/*/base $IPK_ARCH-base
  cp -r $SDK_DIR/bin/targets/${IPK_ARCH%%-*}/${IPK_ARCH##*-}/packages $IPK_ARCH-core
}

download_sdk
get_sources
update_config
build_packages
remove_useless
create_index
copy_packages
