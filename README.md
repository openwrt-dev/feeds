# OpenWrt Feeds

[![CI](https://github.com/openwrt-dev/feeds/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/openwrt-dev/feeds)

## Build

```sh
git clone https://github.com/openwrt-dev/feeds.git --single-branch --recurse-submodules -j$(nproc)
cd feeds

# update upstreams
git submodule update --remote --merge

# ...
# See build.sh
```

## Usage

```sh
# add public key
wget -O /tmp/key-build.pub https://github.com/openwrt-dev/feeds/raw/master/key-build.pub
opkg-key add /tmp/key-build.pub
rm /tmp/key-build.pub

# setup custom feeds
cat << EOF >/etc/opkg/customfeeds.conf
# x86-64
src/gz openwrt_dev_base https://raw.githubusercontent.com/openwrt-dev/feeds/x86-64/base
src/gz openwrt_dev_core https://raw.githubusercontent.com/openwrt-dev/feeds/x86-64/core
EOF
```
