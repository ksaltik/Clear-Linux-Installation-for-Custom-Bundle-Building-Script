    #!/bin/bash
    # Get root privileges
    # sudo -s
    # Enable sshd to login from ssh client
    # echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    # systemctl restart sshd
    # Black        0;30     Dark Gray     1;30
    # Red          0;31     Light Red     1;31
    # Green        0;32     Light Green   1;32
    # Brown/Orange 0;33     Yellow        1;33
    # Blue         0;34     Light Blue    1;34#
    # Purple       0;35     Light Purple  1;35
    # Cyan         0;36     Light Cyan    1;36
    # Light Gray   0;37     White         1;37
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    ORANGE='\033[0;31m'
    lsblk
    sleep 5  # Waits 5 seconds.
    echo "You need more than maybe ${RED}50GB of space to build your own RPM packages"
    echo "You need to install storage utils to extend partition size?"
    options=("Yes" "No")
    select yn in "${options[@]}"
    do
        case $yn in
            "Yes") sudo swupd bundle-add storage-utils; break;;
    #       "No" ) exit;;
            "No" ) break;;

                *) echo "Use 1 or 2 options";continue;;
        esac
    done
    echo -e "We will resize the partition now \n${RED}using parted and resizepart.${NC} \nFirst use ( p ) to print out the partitions."
    echo -e "Then if warning message appears \nabout  - not all space available - ${ORANGE}etc select ( Fix )${NC}"
    echo -e "After Fix there will be info about disk \n${ORANGE}size like - Disk /dev/sda: 67.8GB -${NC} "
    echo -e "Then enter resize ( partition number ) \nthe partition number most probably ${RED}2 so"
    echo -e "${RED}Enter resizepart 2 ${NC} and it will ask you ${RED}the end? ${NC}\nenter the above ${RED}value 67.8GB ${NC}and hit enter and then q to quit"
    sudo parted
    # The partition  resizedwas sda2
    sudo resize2fs -p /dev/sda2
    # Check the size of the disk 
    df -h
    swupd bundle-add kernel-lts
    clr-boot-manager set-timeout 10
    clr-boot-manager update
