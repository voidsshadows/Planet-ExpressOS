#!/bin/sh
set -e

echo "--- Applying Random Bootlogo Patch ---"

# Step 1: Copy your entire `bootlogos` folder into the firmware.
# This brings over the images AND the script inside it.
echo "Installing bootlogo collection and runtime script..."
cp -r "$CURRENT_PATCH_PATH/bootlogos" ./squashfs-root/

# Step 2: Make the script executable in its final location.
# The path is now /bootlogos/randomize-bootlogo.sh because we copied the whole folder.
echo "Setting execute permissions for the runtime script..."
chmod +x ./squashfs-root/bootlogos/randomize-bootlogo.sh

# Step 3: Add a line to a startup file to run the script on every boot.
echo "Configuring script to run on boot..."
echo "/bootlogos/randomize-bootlogo.sh" >> ./squashfs-root/etc/rc.local

echo "--- Random Bootlogo Patch Applied Successfully ---"
