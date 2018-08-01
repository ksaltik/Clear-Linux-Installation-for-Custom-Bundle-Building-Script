#!/bin/bash
# Get root privileges
sudo -s
# Enable sshd to login from ssh client
# echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
# systemctl restart sshd
lsblk
sleep 5  # Waits 5 seconds.
echo "You need more than maybe 50GB ıf space to build your own RPM packages and build custom bundles."
echo "You need to install storage utils to extend partition size?"
select yn in "Yes (1)" "No (2)"; do
    case $yn in
        Yes ) sudo swupd bundle-add storage-utils; break;;
        No ) exit;;
    esac
done
echo "We will resize the partition now using parted and resizepart. First use ( p ) to print out the partitions."
echo "Then if warning message appears about  - not all space available - etc select ( Fix )"
echo "After Fix there will be info about disk size like - Disk /dev/sda: 67.8GB - "
echo "Then enter resize ( partition number ) the partition number most probably 2 so"
echo "Enter resizepart 2 and it will ask you the end? enter the above value 67.8GB and hit enter and then q to quit"
sudo parted
swupd bundle-add kernel-lts
clr-boot-manager set-timeout 10
clr-boot-manager update
