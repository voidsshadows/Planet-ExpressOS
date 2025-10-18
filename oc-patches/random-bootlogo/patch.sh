#!/bin/sh
set -e

echo "--- Applying Random Bootlogo Patch ---"

# Step 1: Copy your bootlogos folder using the correct variable for the destination.
echo "Installing bootlogo collection and runtime script..."
cp -r "$CURRENT_PATCH_PATH/bootlogos" "$SQUASHFS_ROOT/"

# Step 2: Set permissions using the variable to ensure the correct path.
echo "Setting execute permissions for the runtime script..."
chmod +x "$SQUASHFS_ROOT/bootlogos/randomize-bootlogo.sh"

# Step 3: Add the script to the startup file using the variable.
echo "Configuring script to run on boot..."
echo "/bootlogos/randomize-bootlogo.sh &" >> "$SQUASHFS_ROOT/etc/rc.local"

echo "--- Random Bootlogo Patch Applied Successfully ---"
