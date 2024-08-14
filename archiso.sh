#!/bin/bash



clear



# User password
printf "Password: "
read -s password



# Disk
fdisk -l

printf "\nDisk: "
read disk

printf "Disk part name without number: "
read diskPart

printf "g\nn\n\n\n+1G\nt\n1\nn\n\n\n+100G\nn\n\n\n\nw\nq" | fdisk -W always /dev/$disk

partNum=1
mkfs.fat -F32 /dev/$disk$diskPart$partNum

partNum=2
mkfs.ext4 /dev/$disk$diskPart$partNum
mount /dev/$disk$diskPart$partNum /mnt

partNum=3
mkfs.ext4 /dev/$disk$diskPart$partNum
mkdir /mnt/home
mount /dev/$disk$diskPart$partNum /mnt/home



# Kernel and system
while ! pacstrap -K /mnt base linux linux-firmware ; do : ; done

genfstab /mnt -U >> /mnt/etc/fstab



# Change root
cd

printf "disk=$disk\ndiskPart=$diskPart\npassword=$password" > alekuts-archlinux/variables

mv alekuts-archlinux/variables /mnt
mv alekuts-archlinux/arch-chroot.sh /mnt
mv alekuts-archlinux/arch-post-install.sh /mnt

arch-chroot /mnt bash arch-chroot.sh



# Unmount and reboot
umount /mnt -l

reboot
