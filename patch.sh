#!/bin/bash -x
#
# Script to apply the standard patchset for OpenCentauri Firmware Build
#

if [ $UID -ne 0 ]; then
  echo "Error: Please run as root."
  exit 1
fi

echo Go into the squashfs-root dir for the rest of the steps!
cd ./unpacked/squashfs-root

echo Copy over the OpenCentauri bootstrap tarball to /app
cp ../../RESOURCES/OpenCentauri/OpenCentauri-bootstrap.tar.gz ./app
chmod 644 ./app/OpenCentauri-bootstrap.tar.gz

echo Install OpenCentauri firmware public key
cat ../../RESOURCES/KEYS/swupdate_public.pem > ./etc/swupdate_public.pem

echo Install OpenCentauri banner file
cat ../../RESOURCES/OpenCentauri/banner > ./etc/banner

echo Configure bind-shell for recovery purposes on 4567/tcp
cat ../../RESOURCES/OpenCentauri/bind-shell > ./app/bind-shell
chmod 755 ./app/bind-shell
cat ../../RESOURCES/OpenCentauri/12-shell > ./etc/hotplug.d/block/12-shell
chmod 644 ./etc/hotplug.d/block/12-shell

echo Block Elegoo automated FW updates from Chitui via hosts file entry
sed -re '1a # Block automatic software updates from Elegoo\n127.0.0.1 mms.chituiot.com' -i ./etc/hosts

echo Set root password to 'OpenCentauri'
sed -re 's|^root:[^:]+:(.*)$|root:$1$rjtTIZX8$BmFRX/0pY6iP8VemQeOhN/:\1|' -i ./etc/shadow

echo Add mlocate group 
sed -re 's|^(network.+)$|\1\nmlocate:x:102:|' -i ./etc/group

echo Fix fgrep error on login in /etc/profile
sed -re 's|fgrep|grep -F|' -i ./etc/profile

echo Create sshd privilege separation user
echo 'sshd:x:22:65534:OpenSSH Server:/opt/var/empty:/dev/null' >> ./etc/passwd

echo Set hostname to OpenCentauri
sed -re 's|TinaLinux|OpenCentauri|' -i ./etc/config/system

echo Add OpenCentauri initialization to /etc/rc.local
sed -r -e '$ d' -i ./etc/rc.local
cat << EOF >> ./etc/rc.local
# BEGIN: INITIALIZE OpenCentauri and entware
mkdir -p /user-resource/OpenCentauri/entware \\
         /user-resource/OpenCentauri/root \\
         /opt /root
mount -o bind /user-resource/OpenCentauri/entware /opt
mount -o bind /user-resource/OpenCentauri/root /root
# Bootstrap entware and the root homedir if needed!
if [ ! -f /opt/etc/entware_release ]; then
  cd /user-resource &&
    tar zxvf /app/OpenCentauri-bootstrap.tar.gz
fi
# Once entware is properly installed, do the things!
if [ -f /opt/etc/entware_release ]; then
  # Update mlocate db now, and every 24 hours!
  sh -c "while [ 1 ]; do /opt/bin/updatedb; sleep 86400; done" &

  # Generate openssh host keys in /opt/etc/ssh (if needed, else it skips)
  /opt/bin/ssh-keygen -A

  # Start entware system services, includes openssh
  /opt/etc/init.d/rc.unslung start
fi
# END: INITIALIZE OpenCentauri and entware

exit 0
EOF

cd -
