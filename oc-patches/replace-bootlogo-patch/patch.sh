#!/bin/bash

if [ $UID -ne 0 ]; then
  echo "Error: Please run as root."
  exit 1
fi

set -e

cd "$EXTRACTED_FW_ROOT"
mkdir /mnt/bootimg
mount -o loop,rw boot-resource /mnt/bootimg
cp "$CURRENT_PATCH_PATH/bootlogo.bmp" /mnt/bootimg/bootlogo.bmp
umount /mnt/bootimg
rm -rf /mnt/bootimg