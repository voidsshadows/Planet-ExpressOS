#!/bin/bash -x
#
# Script to run through all the firmware extract, patch and build steps!
#

echo "Unpacking the firmware..."
sudo ./unpack.sh FW/FW-CentauriCarbon-v1.1.25-2025-05-09.bin
echo

echo "Patching the firmware..."
sudo ./patch.sh
echo

echo "Re-packing the firmware into update/update.swu..."
sudo ./pack.sh
echo
