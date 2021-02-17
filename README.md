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

- [@openwrt/packages/libs/c-ares](https://github.com/openwrt/packages/tree/openwrt-21.02/libs/c-ares)
- [@openwrt/packages/libs/libev](https://github.com/openwrt/packages/tree/openwrt-21.02/libs/libev)
- [@openwrt/packages/libs/libsodium](https://github.com/openwrt/packages/tree/openwrt-21.02/libs/libsodium)
- [@openwrt/openwrt/package/libs/pcre](https://github.com/openwrt/openwrt/tree/openwrt-21.02/package/libs/pcre)
- ~~[@shadowsocks/openwrt-feeds/packages/libcares](https://github.com/shadowsocks/openwrt-feeds/tree/master/packages/libcares)~~

- [mbedtls](https://github.com/shadowsocks/openwrt-feeds/tree/master/base/mbedtls)

### Credits

https://github.com/simonsmh/openwrt-dist
