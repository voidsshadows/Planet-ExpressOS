#!/bin/sh

# This script is run by the firmware patcher, which is already root.


sleep 30
# Base directory containing the theme subfolders
BOOTLOGO_DIR="/bootlogos"
BOOTIMG="/boot-resource"

# --- Part 1: Randomly select a theme subfolder ---

# Find all immediate subdirectories inside /bootlogos
# -mindepth 1 prevents it from picking /bootlogos itself
# -maxdepth 1 prevents it from going into sub-sub-folders
theme_dirs=$(find "$BOOTLOGO_DIR" -mindepth 1 -maxdepth 1 -type d)

# Count the number of theme folders found
dir_count=$(echo "$theme_dirs" | wc -l)

# Exit if no theme folders are found
if [ "$dir_count" -eq 0 ]; then
    echo "No theme subfolders found in $BOOTLOGO_DIR"
    exit 1
fi

# Pick a random theme folder
rand_dir_num=$(awk -v count="$dir_count" 'BEGIN{srand(); print int(rand()*count)+1}')
SELECTED_THEME=$(echo "$theme_dirs" | sed -n "${rand_dir_num}p")
echo "Selected theme folder: $(basename "$SELECTED_THEME")"


# --- Part 2: Randomly select a BMP from the chosen folder ---

# Find all BMP files inside the randomly selected theme folder
file_list=$(find "$SELECTED_THEME" -maxdepth 1 -type f -name "*.bmp")

# Count the BMP files
count=$(echo "$file_list" | wc -l)

# Exit if the chosen theme folder has no BMP files
if [ "$count" -eq 0 ]; then
    echo "No BMPs found in the selected folder: $SELECTED_THEME"
    exit 1
fi

# Pick a random BMP file from the list
rand_num=$(awk -v count="$count" 'BEGIN{srand(); print int(rand()*count)+1}')
LOGO=$(echo "$file_list" | sed -n "${rand_num}p")


# --- Part 3: Mount and replace the logo (this part is unchanged) ---

mkdir -p /mnt/bootimg
mount -o loop,rw "$BOOTIMG" /mnt/bootimg 2>/dev/null

if mountpoint -q /mnt/bootimg; then
    cp "$LOGO" /mnt/bootimg/bootlogo.bmp
    sync
    umount /mnt/bootimg
    rmdir /mnt/bootimg
else
    cp "$LOGO" "$BOOTIMG/bootlogo.bmp"
    sync
fi

echo "Bootlogo replaced with $(basename "$LOGO")"
