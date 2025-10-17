#!/bin/bash

set -e
cd "$SQUASHFS_ROOT"

# Empty the file so all the patches can add their own code to rc.local
rm ./etc/rc.local
touch ./etc/rc.local
chmod 774 ./etc/rc.local
chown root:root ./etc/rc.local
echo "# Put your custom commands here that should be executed once" >> ./etc/rc.local
echo "# the system init finished. By default this file does nothing." >> ./etc/rc.local
echo "" >> ./etc/rc.local