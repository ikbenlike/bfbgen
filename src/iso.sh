#!/bin/sh
set -e
. ./build.sh

mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/orion.kernel isodir/boot/orion.kernel
cp grub.cfg isodir/boot/grub/grub.cfg

grub-mkrescue -o orion.iso isodir
