#!/bin/bash -e
set -o pipefail
[ "$DEBUG" == 1 ] && set -x

CUR_DIR=$(pwd)
SDK_DIR=$(pwd)/openwrt-sdk

_reserve_ipk_list() {
  cat <<- EOF
	libcares
	libev
	libmbedtls12
	libpcre
	libsodium

	ChinaDNS
	chinadns-ng
	dns-forwarder
	dns2tcp
	hev-socks5-server
	ipt2socks
	portfwd
	shadowsocks-libev-server
	shadowsocks-libev
	simple-obfs-server
	simple-obfs
	udp2raw
	udpspeeder
	vlmcsd
	luci-app-dns-forwarder
	luci-app-shadowsocks

	kmod-ipt-fullconenat
	iptables-mod-fullconenat
	firewall
	luci-app-firewall
	luci-i18n-firewall-zh-cn
	luci-i18n-firewall-zh-tw
EOF
}

download_sdk() {
  curl -sSL $SDK_URL | tar Jxf -
  mv openwrt-sdk-* $SDK_DIR
}

get_sources() {
  cd $SDK_DIR

  # update feeds
  ./scripts/feeds update base luci

  # fullconenat patch for firewall
  ./scripts/feeds install firewall
  cp -r $CUR_DIR/patch/firewall/patches package/network/config/firewall/

  # fullconenat patch for luci-app-firewall
  ./scripts/feeds install luci-app-firewall
  cp -r $CUR_DIR/patch/luci-app-firewall/patches package/feeds/luci/luci-app-firewall/

  # copy local sources
  cp -r $CUR_DIR/libs/* package/
  cp -r $CUR_DIR/net/* package/
  cp $CUR_DIR/key-build .

  cd $CUR_DIR
}

update_config() {
  cd $SDK_DIR

  make defconfig

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
  make -j$(nproc) package/firewall/compile V=w
  make -j$(nproc) package/luci-app-firewall/compile V=w

  cd $CUR_DIR
}

remove_useless() {
  cd $SDK_DIR
  find bin/ -type f $(printf " ! -name %s*" $(_reserve_ipk_list)) | xargs rm -f
  cd $CUR_DIR
}

create_index() {
  cd $SDK_DIR
  make package/index V=s
  cd $CUR_DIR
}

copy_packages() {
  cp -r $SDK_DIR/bin/packages/*/base $IPK_ARCH-base
  cp -r $SDK_DIR/bin/packages/*/luci $IPK_ARCH-luci
  cp -r $SDK_DIR/bin/targets/${IPK_ARCH%%-*}/${IPK_ARCH##*-}/packages $IPK_ARCH-core
}

download_sdk
get_sources
update_config
build_packages
remove_useless
create_index
copy_packages
