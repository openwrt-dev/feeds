# OpenWrt Feeds

[![CI](https://github.com/openwrt-dev/feeds/workflows/CI/badge.svg)](https://github.com/openwrt-dev/feeds)
[![CDN](https://data.jsdelivr.com/v1/package/gh/openwrt-dev/feeds/badge?style=rounded)](https://cdn.jsdelivr.net/gh/openwrt-dev/feeds/)

### Build

```bash
git clone https://github.com/openwrt-dev/feeds.git -b master --single-branch --recurse-submodules -j4
cd feeds

# update upstreams
git submodule update --remote --merge

# ...
# See build.sh
```

### Usage

Setup opkg configs following those lines:
```bash
# ath79-generic
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ath79-generic/base

# ath79-tiny
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ath79-tiny/base

# ramips-mt7620
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ramips-mt7620/base

# ramips-mt7621
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ramips-mt7621/base

# x86-64
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/x86-64/base
```

### Upstreams

- [mbedtls](https://github.com/shadowsocks/openwrt-feeds/tree/master/base/mbedtls)
- [pcre](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/pcre)
- [libev](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/libev)
- [libcares](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/libcares)
- [libsodium](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/libsodium)
- ~~[libcares](https://github.com/openwrt/packages/tree/master/libs/c-ares)~~
- ~~[libsodium](https://github.com/openwrt/packages/tree/master/libs/libsodium)~~

### Credits

https://github.com/simonsmh/openwrt-dist
