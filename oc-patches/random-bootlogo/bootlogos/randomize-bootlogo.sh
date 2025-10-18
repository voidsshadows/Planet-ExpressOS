#!/opt/bin/bash
set -e

BOOTLOGO_DIR="/bootlogos"
BOOTIMG="/boot-resource"

# Move into the bootlogos directory
cd "$BOOTLOGO_DIR"

# Find all BMP files
mapfile -t files < <(find . -maxdepth 1 -type f -name "*.bmp")

if [ "${#files[@]}" -eq 0 ]; then
    echo "No BMPs found in $BOOTLOGO_DIR"
    exit 1
fi

# Pick a random file
rand_index=$((RANDOM % ${#files[@]}))
FILE="${files[$rand_index]}"

# Ensure the filename ends with .bmp (safety)
if [[ ! "$FILE" == *.bmp ]]; then
    FILE="$FILE.bmp"
fi

# Check file exists
if [[ -f "$FILE" ]]; then
    echo "Applying bootlogo $FILE"
else
    echo "Failed to find $FILE in $BOOTLOGO_DIR"
    exit 1
fi

# Remount boot resource RW
mount -o remount,rw "$BOOTIMG"

# Delete old bootlogo if it exists
if [[ -f "$BOOTIMG/bootlogo.bmp" ]]; then
    rm -f "$BOOTIMG/bootlogo.bmp"
fi

# Copy new bootlogo
cp "$FILE" "$BOOTIMG/bootlogo.bmp"
sync

echo "Done! Bootlogo replaced with $(basename "$FILE")"
