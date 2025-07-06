#!/bin/bash

project_root="$PWD"

# Source the utils.sh file
source "$project_root/TOOLS/helpers/utils.sh" "$project_root"

echo "Downloading Centauri Carbon Firmware version 1.1.25 from 2025-05-09..."
echo
# old url format up to 3.0.9
#url_zip="https://cdn.cloud-universe.anycubic.com/ota/${par_model}/AC104_${par_model}_1.1.0_${par_version}_update.zip"
url_bin="https://download.chitubox.com/chitusystems/chitusystems/public/printer/firmware/release/1/ca8e1d9a20974a5896f8f744e780a8a7/1/1.1.25/2025-05-09/219b4c9e67de4a1d99c7680164911ab5.bin"
file_bin="FW/FW-CentauriCarbon-v1.1.25-2025-05-09.bin"
curl "$url_bin" --output "$file_bin"
result=$(grep "<Code>NoSuchKey</Code>" "$file_bin")
file_size=$(wc -c "$file_bin" | awk '{print $1}')
echo
if [ -n "$result" ] || [ "$file_size" -le 1000000 ]; then
  rm -f "$file_bin"
  echo -e "${RED}ERROR: Cannot find an update for this model and version ${NC}"
  exit 3
else
  echo -e "${GREEN}Success! ${NC}"
fi
