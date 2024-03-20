#!/bin/sh

download_sdk() {
  curl -sSL "$SDK_URL" | tar Jxf -
  mv openwrt-sdk-* openwrt-sdk
}

get_sources() {
  (
    cd openwrt-sdk || exit 1

    # prepare install depends
    ./scripts/feeds update base packages
    # depends on `openwrt-fullconenat`
    ./scripts/feeds install libxtables

    # copy sources
    cp -r ../src/* package/
    cp ../key-build .
  )
}

build_packages() {
  trim() {
    sed '/^[[:space:]]*$/d' | sed '/^#/d'
  }

  (
    cd openwrt-sdk || exit 1

    make defconfig

    # some packages cannot compile with ccache, like `openwrt-vlmcsd`.
    sed -i '/^CONFIG_CCACHE=y/d' .config

    while read -r package; do
      # shellcheck disable=SC2086
      make -j$(($(nproc) + 1)) package/${package}/compile V=w ||
        make -j1 package/${package}/compile V=s ||
        exit 1
    done <../packages.txt | awk -F: '{print $1}' | trim

    # remove useless packages
    # shellcheck disable=SC2046
    find bin -type f $(printf " ! -name %s_*" $(awk -F: '{print $2}' ../packages.txt | trim | tr ',' '\n')) -delete

    make package/index V=s
  )
}

download_sdk
get_sources
build_packages
