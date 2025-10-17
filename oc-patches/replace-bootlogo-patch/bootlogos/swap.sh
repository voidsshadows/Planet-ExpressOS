#!/opt/bin/bash

set -e

cd /bootlogos

FILE="$1"

if [[ ! "$FILE" == "*.bmp" ]]
then
    FILE="$FILE.bmp"
fi

if [[ -f "$FILE" ]]
then
    echo "Applying bootlogo $FILE"
else
    echo "Failed to find $FILE in /bootlogos"
    exit 1
fi

mount -o remount,rw /boot-resource
cp "$FILE" /boot-resource/bootlogo.bmp
sync
echo "Done!"
