#!/bin/bash
lsblk
sleep 5  # Waits 5 seconds.
echo "You need more than maybe 50GB ıf space to build your own RPM packages and build custom bundles."
echo "You need to install storage utils to extend partition size?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo swupd bundle-add storage-utils; break;;
        No ) exit;;
    esac
done
swupd bundle-add kernel-lts
clr-boot-manager set-timeout 10
clr-boot-manager update
