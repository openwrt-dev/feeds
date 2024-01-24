#!/bin/bash -e
set -o pipefail
[ "$DEBUG_LOG" = 1 ] && set -x

CUR_DIR=$(pwd)
SDK_DIR=$(pwd)/openwrt-sdk

trim_lines() {
  sed '/^[[:space:]]*$/d' | sed '/^#/ d'
}

update_feeds() {
  if [ ! -f $SDK_DIR/.feeds_updated ]; then
    ./scripts/feeds update base packages
    touch $SDK_DIR/.feeds_updated
  fi
}

install_feeds() {
  update_feeds
  ./scripts/feeds install "$@"
}

install_feeds_with_patches() {
  local target_dir="$1"
  local package_name=$(basename "$1")
  update_feeds
  ./scripts/feeds install $package_name
  cp -rv $CUR_DIR/patch/$package_name/patches $target_dir
}

build_package() {
  local package="$1"
  if [ "$DEBUG_LOG" != 1 ]; then
    make -j$(nproc) package/$package/compile V=w
  else
    make -j1 package/$package/compile V=s
  fi
}
