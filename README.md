# OpenCentauri Firmware Tools

## Background

This repo was forked from the wonderful AnyCubic Kobra Firmware tools by ultimateshadsform. Props to them for all the amazing work they put into this!

Scripts have been modified, re-written, tweaked etc. to support similar firmware tasks for the Elegoo Centauri Carbon printer and firmware.

Please note that if a script is not specifically called-out in this README, it probably hasn't been tested with the Carbon firmware and might break something or brick your printer!

If there are two versions of a script, and one has an -ac in the name, this is the original AnyCubic version of the file for reference.

## Download the Base Firmware

1. Download the 1.1.25 FW to FW/:
    `./fwdl.sh`

## Build the OpenCentauri Firmware Image

### Option 1: Manual Build

1. Unpack the firmware of choice: (tested with 1.1.25)
    `sudo ./rc.unpack FW-CentauriCarbon-v1.1.25-2025-05-09.bin`
1. Run this patch set of updates to the squashfs extracted:
    `sudo ./rc.patch`
1. Generate a new update.swu:
    `sudo ./rc.pack`

### Option 2: Automatic Build

1. Run through all the steps in Option 1:
    `./rc.build`

## Install to Printer

1. Install to the printer (note: have to edit the hostname/IP in this script):
    `./TOOLS/custom_install.sh`
1. Alternative:
    1. Copy update/update.swu to USB stick, in the folder update, file update.swu
    1. Reboot the printer and it should detect an update is available.
