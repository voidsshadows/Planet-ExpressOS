# OpenCentauri Changelog

All notable updates to OpenCentauri FW build and defaults will be documented in this file.

## [v0.1.0] - 2025-10-15 New patching system
**GitHub Release:** [`v0.1.0`](https://github.com/OpenCentauri/cc-fw-tools/releases/tag/v0.1.0)  

- Fix OC-firmware for 1.1.40
- Added new patching system (can plan patches around before/after other patches + can constrain to a version).
- New patch: Replace bootlogo, both from the patching system and while running the system (currently has 5 bootlogos available)
- New patch: Set homing position to front right (1.1.40 specific)
- New patch: Disable automatically re-enabling the exhaust fan based on filament type (1.1.40 specific)
- New patch: Block Elegoo updates
- New patch: Block connectivity checks
- New patch: Allow API access during printing (1.1.40 specific)
- New patch: Add chamber light gcode commands (1.1.40 specific)

Release is based off the 1.1.40 firmware image from Elegoo.

**Full Changelog**: https://github.com/OpenCentauri/cc-fw-tools/compare/v0.0.4...v0.1.0

## [v0.0.5] - 2025-10-XX TBD
**GitHub Release:** [`v0.0.5`](https://github.com/OpenCentauri/cc-fw-tools/releases/tag/v0.0.5)  

- Running changelog for 0.0.5, plan is to try and rebase on 1.1.40 or 1.1.42
- Updated OpenCentauri firmware build and deploy process with a few additions:
  - `fwdl.sh` and `build.sh` now support an optional version argument to specify which firmware version to download and build. Defaults to 1.1.40.

## [v0.0.4] - 2025-08-24
**GitHub Release:** [`v0.0.4`](https://github.com/OpenCentauri/cc-fw-tools/releases/tag/v0.0.4)  

- Updated OpenCentauri firmware build and deploy process with a few additions:
  - Enable uboot console output on serial UART (3.3v)
  - Enable rootshell on serial UART (press enter after boot-up)
  - Change SWU process from `./install.sh` to just use `/mnt/UDISK` (so no real USB stick involved anymore)

## [v0.0.3] - 2025-07-29
**GitHub Release:** [`v0.0.3`](https://github.com/OpenCentauri/cc-fw-tools/releases/tag/v0.0.3)  

- Updated OpenCentauri firmware build and deploy process with a few additions:
  - Now mounts usb on boot-up (or if you plug in USB after boot!) without needing /app/app running.
  - Auto-upload and patch process now works withou /app/app, should be able to run ./install.sh after building a custom FW and it should install even w/out /app/app
  - There might still be some holes in this depending on what you are doing but reach out if you find one!
  - Note: You do need a USB drive plugged in to update the FW with ./install.sh
- Added default 10s delay for /app/app boot, and auto halt boot of app if a Pi in gadget mode is detected!

## [v0.0.2] 
**GitHub Release:** [`v0.0.1`](https://github.com/OpenCentauri/cc-fw-tools/releases/tag/v0.0.2)
### Stuff
  - Stuff
  - Fill me in

## [v0.0.1] 
**GitHub Release:** [`v0.0.1`](https://github.com/OpenCentauri/cc-fw-tools/releases/tag/v0.0.1)  
- Initial release
### Onboard Mods:
  - Patch in a new OpenCentauri graphic for the web UI
  - Enable persistent Entware deployment
  - Install OpenSSH server, generate keys and start on boot
  - Install Sims root shell socket for failsafe recovery on 4567/tcp
  - Configure bash as the 'default' shell for root (not really just for failsafe purposes, but effectively)
### Firmware Tools:
  - Initial version of README.md with lots of documentation!

  - `./fwdl.sh` script to download the 1.1.25 Elegoo firmware that we will be basing this build on
  - `./unpack.sh` script to extract all the pieces of the Elegoo FW
  - `./patch.sh` script to apply our patches
  - `./pack.sh` script to re-pack our OpenCentauri custom FW
  - `./upload.sh` script to flash a compiled update.swu to your printer without needing to manually USB stick it over!
  - `./build.sh` script to run unpack, patch and pack all in one step
