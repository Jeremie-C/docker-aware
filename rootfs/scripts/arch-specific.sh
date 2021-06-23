#!/bin/sh
arch=$(dpkg --print-architecture)

case $arch in
  amd64)
    dpkg --add-architecture armhf
    apt-get update
    apt-get install --no-install-recommends -y rbfeeder:armhf
    rm -f /etc/services.d/rbfeeder/run
    mv /etc/services.d/rbfeeder/run.qemu /etc/services.d/rbfeeder/run    
    ;;
  i386)
    dpkg --add-architecture armhf
    apt-get update
    apt-get install --no-install-recommends -y rbfeeder:armhf
    rm -f /etc/services.d/rbfeeder/run
    mv /etc/services.d/rbfeeder/run.qemu /etc/services.d/rbfeeder/run    
    ;;
  armhf)
    apt-get update
    apt-get install --no-install-recommends -y rbfeeder
    ;;
  arm64)
    dpkg --add-architecture armhf
    apt-get update
    apt-get install --no-install-recommends -y rbfeeder:armhf
    ;;
  armel)
    dpkg --add-architecture armhf
    apt-get update
    apt-get install --no-install-recommends -y rbfeeder:armhf
    ;;
  *)
    exit 1
    ;;
esac
