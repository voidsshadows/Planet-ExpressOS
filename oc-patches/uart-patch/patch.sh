#!/bin/bash

# Note: This patch currently disables the scree on the Elegoo CC making it un-usable for printing
# We are working on an updated uBoot binary that will enable UART and also allow screen use!
# For now this is only useful for devs doing DSP or Kernel development.

set -e
cd "$REPOSITORY_ROOT"
OPTIONS_DIR="./RESOURCES/OPTIONS" ./RESOURCES/OPTIONS/uart/uart.sh . 2.3.9
