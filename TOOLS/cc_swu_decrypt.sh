#!/bin/bash

BIN="$(dirname $0)/cc_swu_decrypt.py"
# Decryption key for logs
#KEY="6DE30155B7964E8CF0F3D2465997A458F8B56FF7E1E537597E9B5861062B4742"
#IV="001F35A46358F76877C3382764460775"
# Decryption key for FW
KEY="78B6A614B6B6E361DC84D705B7FDDA33C967DDF2970A689F8156F78EFE0B1FCE"
IV="54E37626B9A699403064111F77858049"
#outfile="unpacked/update.swu"
outfile="unpacked/update.zip"

while [ $# -gt 0 ]; do
  if [ "$1" = "-i" ]; then
    shift
    infile="$1"
    shift
  fi
  if [ "$1" = "-o" ]; then
    shift
    outfile="$1"
    shift
  fi
done

if [ -z "$infile" ] || [ -z "$outfile" ]; then
  printf "Usage: %s -i <firmware.bin> -o <update.zip>\n" "$0"
  exit 1
fi

set -x
exec "$BIN" "$infile" "$KEY" "$IV" "$outfile"
