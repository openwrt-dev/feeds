# OpenWrt Feeds

[![CI](https://github.com/openwrt-dev/feeds/workflows/CI/badge.svg)](https://github.com/openwrt-dev/feeds)

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

Setup opkg configs, e.g. x86-64:
```bash
# x86-64
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/x86-64/base
src/gz openwrt_dev_core https://github.com/openwrt-dev/feeds/raw/x86-64/core
```

### Upstreams

- [@openwrt/openwrt/package/libs/mbedtls](https://github.com/openwrt/openwrt/tree/openwrt-21.02/package/libs/mbedtls)
- [@openwrt/openwrt/package/network/config/firewall](https://github.com/openwrt/openwrt/tree/openwrt-21.02/package/network/config/firewall)
- [@openwrt/luci/applications/luci-app-firewall](https://github.com/openwrt/luci/tree/openwrt-21.02/applications/luci-app-firewall)

### Credits

- https://github.com/simonsmh/openwrt-dist
