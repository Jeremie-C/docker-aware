#!/bin/sh
arch=$(dpkg --print-architecture)

case $arch in
  amd64)
    apt-get install -y --no-install-recommends qemu-user qemu-user-static binfmt-support
    ;;
  i386)
    apt-get install -y --no-install-recommends qemu-user qemu-user-static binfmt-support
    ;;
  *)
    exit 1
    ;;
esac
