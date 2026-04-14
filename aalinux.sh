#!/bin/bash

DISK="/dev/"
EFI_PART="/dev/"
ROOT_HOME_PART="/dev/"

clear

while true; do
    read -sp "Password: " PASS1 && echo
    read -sp "Retype password: " PASS2 && echo

    if [ "$PASS1" = "$PASS2" ] && [ -n "$PASS1" ]; then
        PASSWORD=$PASS1
        echo "Done"
        break
    else
        echo "Wrong password"
    fi
done

printf "EFI_PART=$EFI_PART\nPASSWORD=$PASSWORD" > /mnt/variables

fdisk -W always $DISK <<EOF
g
n
1

+1G
t
1
n
2


w
EOF

mkfs.fat -F32 $EFI_PART
mkfs.btrfs $ROOT_HOME_PART

mount $ROOT_HOME_PART /mnt
cd /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount -l /mnt

mount -o compress=zstd:1,subvol=@ $ROOT_HOME_PART /mnt
mkdir /mnt/home
mkdir /mnt/efi
mount -o compress=zstd:1,subvol=@home $ROOT_HOME_PART /mnt/home
mount $EFI_PART /mnt/efi

while ! pacstrap -K /mnt base linux linux-firmware ; do sleep 1 ; done
genfstab -U /mnt >> /mnt/etc/fstab

cd
mv alekuts-archlinux/chrootaalinux.sh /mnt
mv alekuts-archlinux/postaalinux.sh /mnt

arch-chroot /mnt bash chrootaalinux.sh

umount /mnt -l
reboot
