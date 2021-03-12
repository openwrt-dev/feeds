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
src/gz openwrt_dev_core https://github.com/openwrt-dev/feeds/raw/ath79-generic/core
src/gz openwrt_dev_luci https://github.com/openwrt-dev/feeds/raw/ath79-generic/luci
src/gz openwrt_dev_packages https://github.com/openwrt-dev/feeds/raw/ath79-generic/packages

# ath79-tiny
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ath79-tiny/base
src/gz openwrt_dev_core https://github.com/openwrt-dev/feeds/raw/ath79-tiny/core
src/gz openwrt_dev_luci https://github.com/openwrt-dev/feeds/raw/ath79-tiny/luci
src/gz openwrt_dev_packages https://github.com/openwrt-dev/feeds/raw/ath79-tiny/packages

# ramips-mt7620
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ramips-mt7620/base
src/gz openwrt_dev_core https://github.com/openwrt-dev/feeds/raw/ramips-mt7620/core
src/gz openwrt_dev_luci https://github.com/openwrt-dev/feeds/raw/ramips-mt7620/luci
src/gz openwrt_dev_packages https://github.com/openwrt-dev/feeds/raw/ramips-mt7620/packages

# ramips-mt7621
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/ramips-mt7621/base
src/gz openwrt_dev_core https://github.com/openwrt-dev/feeds/raw/ramips-mt7621/core
src/gz openwrt_dev_luci https://github.com/openwrt-dev/feeds/raw/ramips-mt7621/luci
src/gz openwrt_dev_packages https://github.com/openwrt-dev/feeds/raw/ramips-mt7621/packages

# x86-64
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/x86-64/base
src/gz openwrt_dev_core https://github.com/openwrt-dev/feeds/raw/x86-64/core
src/gz openwrt_dev_luci https://github.com/openwrt-dev/feeds/raw/x86-64/luci
src/gz openwrt_dev_packages https://github.com/openwrt-dev/feeds/raw/x86-64/packages
```

### Upstreams

- [@openwrt/openwrt/package/libs/mbedtls](https://github.com/openwrt/openwrt/tree/openwrt-19.07/package/libs/mbedtls)
- [@openwrt/openwrt/package/network/config/firewall](https://github.com/openwrt/openwrt/tree/openwrt-19.07/package/network/config/firewall)
- [@openwrt/luci/applications/luci-app-firewall](https://github.com/openwrt/luci/tree/openwrt-19.07/applications/luci-app-firewall)

### Credits

- https://github.com/simonsmh/openwrt-dist
