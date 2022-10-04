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

1. Add public key:
```bash
wget -O /tmp/key-build.pub https://github.com/openwrt-dev/feeds/raw/master/key-build.pub
opkg-key add /tmp/key-build.pub
rm /tmp/key-build.pub
```

2. Setup custom feeds at `/etc/opkg/customfeeds.conf`, e.g. `x86-64` architecture:
```bash
# x86-64
src/gz openwrt_dev_base https://github.com/openwrt-dev/feeds/raw/x86-64/base
src/gz openwrt_dev_core https://github.com/openwrt-dev/feeds/raw/x86-64/core
```

### Reference

- https://github.com/simonsmh/openwrt-dist
