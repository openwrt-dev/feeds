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

Add public key:
```bash
wget -O /tmp/key-build.pub https://github.com/openwrt-dev/feeds/raw/master/key-build.pub
opkg-key add /tmp/key-build.pub
rm /tmp/key-build.pub
```

Setup opkg configs:
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
- [@openwrt/openwrt/package/libs/mbedtls](https://github.com/openwrt/openwrt/tree/openwrt-21.02/package/libs/mbedtls)
- [@openwrt/openwrt/package/libs/pcre](https://github.com/openwrt/openwrt/tree/openwrt-21.02/package/libs/pcre)

### Credits

- https://github.com/simonsmh/openwrt-dist
