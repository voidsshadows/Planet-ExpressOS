#!/opt/bin/bash

set -e

cd /bootlogos

# Get a list of all BMP files
FILES=(*.bmp)

# Check if any BMPs exist
if [[ ${#FILES[@]} -eq 0 ]]; then
    echo "No BMP files found in /bootlogos"
    exit 1
fi

# File to store last used logo
LAST_FILE="/boot-resource/.last_bootlogo"

# Read last used file if it exists
if [[ -f "$LAST_FILE" ]]; then
    LAST_USED=$(cat "$LAST_FILE")
else
    LAST_USED=""
fi

# Pick a random file, but avoid repeating the last one
RANDOM_FILE="$LAST_USED"
while [[ "$RANDOM_FILE" == "$LAST_USED" ]]; do
    RANDOM_FILE="${FILES[RANDOM % ${#FILES[@]}]}"
done

echo "Applying random bootlogo $RANDOM_FILE"

# Make /boot-resource writable
mount -o remount,rw /boot-resource

# Copy the selected file
cp "$RANDOM_FILE" /boot-resource/bootlogo.bmp
sync

# Save this selection for next boot
echo "$RANDOM_FILE" > "$LAST_FILE"

echo "Done!"
