    #!/bin/bash
    # Get root privileges
    # sudo -s
    # Enable sshd to login from ssh client
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    systemctl restart sshd
    echo "Add bridget network adapter as a second ethernet adapter"
    echo "${ORANGE}Get the ip address to connect from ssh client${NC}"
    ifconfig
    sleep 2
    # Color codes etc
    #https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    ORANGE='\033[0;33m'
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
