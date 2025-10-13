#!/bin/bash

if [ $UID -ne 0 ]; then
  echo "Error: Please run as root."
  exit 1
fi

set -e

project_root="$REPOSITORY_ROOT"
source "$project_root/TOOLS/helpers/utils.sh" "$project_root"
check_tools "git"

mv "$SQUASHFS_ROOT/app/resources/configs/printer.cfg" printer.cfg
git apply patch.diff
mv printer.cfg "$SQUASHFS_ROOT/app/resources/configs/printer.cfg"