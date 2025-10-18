#!/opt/bin/bash
set -e

# Go to bootlogos folder
cd /bootlogos || exit 0

# Get all BMP files
FILES=(*.bmp)
if [[ ${#FILES[@]} -eq 0 ]]; then
    echo "No bootlogos found, exiting."
    exit 0
fi

# Track last used logo to avoid repeats
LAST_FILE="/boot-resource/.last_bootlogo"
if [[ -f "$LAST_FILE" ]]; then
    LAST_USED=$(cat "$LAST_FILE")
else
    LAST_USED=""
fi

# Pick a new random logo
RANDOM_FILE="$LAST_USED"
while [[ "$RANDOM_FILE" == "$LAST_USED" ]]; do
    RANDOM_FILE="${FILES[RANDOM % ${#FILES[@]}]}"
done

# Apply the random logo
echo "Applying random bootlogo $RANDOM_FILE"
mount -o remount,rw /boot-resource
cp "$RANDOM_FILE" /boot-resource/bootlogo.bmp
sync

# Save choice for next boot
echo "$RANDOM_FILE" > "$LAST_FILE"
