#!/bin/sh



BOOTLOGO_DIR="/bootlogos"

BOOTIMG="/boot-resource"



# Find all BMP files safely

file_list=$(find "$BOOTLOGO_DIR" -maxdepth 1 -type f -name "*.bmp")



# Count BMP files

count=$(echo "$file_list" | wc -l)



if [ "$count" -eq 0 ]; then

    echo "No BMPs found in $BOOTLOGO_DIR"

    exit 1

fi



# Pick a random number using awk (this is the corrected line)

rand_num=$(awk -v count="$count" 'BEGIN{srand(); print int(rand()*count)+1}')



# Get the randomly selected filename

LOGO=$(echo "$file_list" | sed -n "${rand_num}p")



echo "Picked $LOGO"



# Mount boot partition (optional, may already be mounted)

mkdir -p /mnt/bootimg

mount -o loop,rw "$BOOTIMG" /mnt/bootimg 2>/dev/null



# Replace logo

if [ -d "/mnt/bootimg" ]; then

    cp "$LOGO" /mnt/bootimg/bootlogo.bmp

    sync

    umount /mnt/bootimg 2>/dev/null

    rmdir /mnt/bootimg 2>/dev/null

else

    # fallback: copy directly if mount fails

    cp "$LOGO" "$BOOTIMG/bootlogo.bmp"

    sync

fi



echo "Bootlogo replaced with $(basename "$LOGO")"
