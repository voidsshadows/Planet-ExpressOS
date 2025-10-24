#!/usr/bin/env bash
if [ "$UID" -ne 0 ]; then
  echo "Error: Please run as root."
  exit 1
fi

set -e

# Make sure required variables are set
if [ -z "$CURRENT_PATCH_PATH" ] || [ -z "$SQUASHFS_ROOT" ]; then
  echo "Error: CURRENT_PATCH_PATH or SQUASHFS_ROOT not set."
  exit 1
fi

# Ensure target directory exists
mkdir -p "$SQUASHFS_ROOT/app/resources/images"

# Copy exploding.png and rename to 1.png (overwrite if it exists)
cp -f "$CURRENT_PATCH_PATH/images/exploding.png" "$SQUASHFS_ROOT/app/resources/images/1.png"

echo "✅ exploding.png copied and renamed to 1.png in $SQUASHFS_ROOT/app/resources/images/"
