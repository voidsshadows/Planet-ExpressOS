#!/bin/bash

# Ensure root
if [ $UID -ne 0 ]; then
  echo "Error: Please run as root."
  exit 1
fi

set -e

# Go to the extracted firmware root
cd "$EXTRACTED_FW_ROOT"

# Copy bootlogos folder into firmware squashfs
cp -r "$CURRENT_PATCH_PATH/bootlogos" ./squashfs-root/bootlogos

# Prepare /boot-resource mount
mkdir -p /mnt/bootimg
mount -o loop,rw boot-resource /mnt/bootimg

# Copy the random_swap.sh script into /boot-resource
cp "$CURRENT_PATCH_PATH/random_swap.sh" /mnt/bootimg/random_swap.sh
chmod +x /mnt/bootimg/random_swap.sh

# Copy all bootlogos to /boot-resource so the script can pick from them
cp -r "$CURRENT_PATCH_PATH/bootlogos" /mnt/bootimg/bootlogos

umount /mnt/bootimg
rm -rf /mnt/bootimg

echo "Random Bootlogo Swapper installed!"

