#!/usr/bin/env bash
if [ $UID -ne 0 ]; then
  echo "Error: Please run as root."
  exit 1
fi

set -e

cd "$EXTRACTED_FW_ROOT"

# Replace old image with exploding.png renamed to 1
cp -f "$EXTRACTED_FW_ROOT/images/exploding.png" "$EXTRACTED_FW_ROOT/app/resources/images/1"
