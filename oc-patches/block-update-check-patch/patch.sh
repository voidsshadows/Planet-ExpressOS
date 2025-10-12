#!/bin/bash

set -e
cat ./rc.local >> "$SQUASHFS_ROOT/etc/rc.local"