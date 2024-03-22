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
sh <(wget -qO- https://raw.githubusercontent.com/openwrt-dev/feeds/master/add-feeds.sh)
```
