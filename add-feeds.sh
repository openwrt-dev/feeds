#!/bin/sh

# import key
wget https://raw.githubusercontent.com/openwrt-dev/feeds/master/key-build.pub -qO /tmp/key-build.pub
opkg-key add /tmp/key-build.pub
rm /tmp/key-build.pub

# add feeds
TARGET_PLATFORM="$(grep "OPENWRT_BOARD" /etc/os-release | awk -F= '{print $2}' | sed 's/"//g' | tr '/' '-')"
cat <<EOF >>/etc/opkg/customfeeds.conf

# $TARGET_PLATFORM
src/gz openwrt_dev_base https://raw.githubusercontent.com/openwrt-dev/feeds/${TARGET_PLATFORM}/base
src/gz openwrt_dev_core https://raw.githubusercontent.com/openwrt-dev/feeds/${TARGET_PLATFORM}/core
EOF
