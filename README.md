# OpenWrt Feeds

[![Build Status](https://travis-ci.org/openwrt-dev/feeds.svg?branch=master)](https://travis-ci.org/openwrt-dev/feeds)

### Build

```bash
apt-get install gcc g++ make automake autoconf libtool git \
  ccache file patch curl quilt gawk time fakeroot gettext \
  pkg-config python2.7-minimal libssl-dev libncurses5-dev \
  zlib1g-dev bzip2 xz-utils unzip --no-install-recommends

git clone https://github.com/openwrt-dev/feeds.git -b master --single-branch
cd feeds
git submodule update --init --recursive

# update upstreams
git submodule update --remote --merge

# ...
# See build.sh
```

### Usage

Setup opkg configs following those lines:
```bash
# ar71xx-generic
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ar71xx-generic/base

# ar71xx-tiny
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ar71xx-tiny/base

# ramips-mt7620
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ramips-mt7620/base

# x86-64
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/x86-64/base
```

### Upstreams

- [mbedtls](https://github.com/shadowsocks/openwrt-feeds/tree/master/base/mbedtls)
- [pcre](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/pcre)
- [libev](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/libev)
- [libcares](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/libcares)
- [libsodium](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/libsodium)
- [libuv](https://github.com/openwrt/packages/tree/master/libs/libuv)
- ~~[libcares](https://github.com/openwrt/packages/tree/master/libs/c-ares)~~
- ~~[libsodium](https://github.com/openwrt/packages/tree/master/libs/libsodium)~~

### Reference

1. https://github.com/simonsmh/lede-dist
2. https://github.com/isjerryxiao/r6220-openwrt
