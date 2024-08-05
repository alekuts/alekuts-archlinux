#!/bin/bash



# Disk
fdisk -l

read disk

read diskW

echo -e "g\nn\n\n\n+1G\nt\n1\nn\n\n\n+100G\nn\n\n\n\nw\nq" | fdisk -W always /dev/$disk

diskPart=1

mkfs.fat -F32 /dev/$disk$diskW$diskPart

diskPart=2

mkfs.ext4 /dev/$disk$diskW$diskPart

mount /dev/$disk$diskW$diskPart /mnt

diskPart=3

mkfs.ext4 /dev/$disk$diskW$diskPart

mkdir /mnt/home

mount /dev/$disk$diskW$diskPart /mnt/home



# Kernel and system
while ! pacstrap -K /mnt base linux linux-firmware ; do : ; done

genfstab /mnt -U >> /mnt/etc/fstab



# Change root
cd

echo "disk=$disk
diskW=$diskW" > alekuts-archlinux/disk

cp alekuts-archlinux/disk /mnt

cp alekuts-archlinux/arch-chroot.sh /mnt

arch-chroot /mnt bash arch-chroot.sh



# Unmount and reboot
umount /mnt -l

reboot
