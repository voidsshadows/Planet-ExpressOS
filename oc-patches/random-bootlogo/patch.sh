#!/bin/sh

# This check ensures the script is run with root privileges.
# However, the build system that runs this patch is already root, so this isn't necessary.
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: This script must be run as root."
  exit 1
fi

set -e

echo "--- Applying Random Bootlogo Patch ---"

# Step 1: Copy your entire `bootlogos` folder into the firmware.
# This brings over the images AND the script inside it.
echo "Installing bootlogo collection and runtime script..."
cp -r "$CURRENT_PATCH_PATH/bootlogos" ./squashfs-root/

# Step 2: Make the script executable in its final location.
echo "Setting execute permissions for the runtime script..."
chmod +x ./squashfs-root/bootlogos/randomize-bootlogo.sh

# Step 3: Add a line to a startup file to run the script on every boot.
echo "Configuring script to run on boot..."
echo "/bootlogos/randomize-bootlogo.sh &" >> ./squashfs-root/etc/rc.local

echo "--- Random Bootlogo Patch Applied Successfully ---"
