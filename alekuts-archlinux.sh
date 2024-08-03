#!/bin/bash



# Disk
fdisk -l

read disk

echo -e "g\nn\n\n\n+1G\nt\n1\nn\n\n\n+100G\nn\n\n\n\nw\nq" | fdisk -W always /dev/$disk

diskPart=1

mkfs.fat -F32 /dev/$disk$diskPart

diskPart=2

mkfs.ext4 /dev/$disk$diskPart

mount /dev/$disk$diskPart /mnt

diskPart=3

mkfs.ext4 /dev/$disk$diskPart

mkdir /mnt/home

mount /dev/$disk$diskPart /mnt/home



# Kernel and system
while ! pacstrap -K /mnt base linux linux-firmware ; do : ; done

genfstab /mnt -U >> /mnt/etc/fstab



# System root
root="arch-chroot /mnt"



# Programs
$root pacman-key --init

$root pacman-key --populate

sed -Ei 's/#(\[multilib\])/\1/' /mnt/etc/pacman.conf

sed -i '/\[multilib\]/ {n;s/#//}' /mnt/etc/pacman.conf

while ! $root pacman -Syu --noconfirm dhcpcd sudo grub efibootmgr xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk font-manager pulseaudio pulseaudio-alsa alsa-utils fuse2 libmtp gvfs-mtp thunar flameshot git steam wine wine-mono wine-gecko nvidia ; do : ; done



# Time
$root systemctl enable dhcpcd

$root ln -sf /usr/share/zoneinfo/Europe/Kyiv /etc/localtime

$root hwclock --systohc



# Locale
sed -Ei 's/#(de_DE.*UTF-8)/\1/' /mnt/etc/locale.gen

sed -Ei 's/#(en_US.*UTF-8)/\1/' /mnt/etc/locale.gen

sed -Ei 's/#(ja_JP.*UTF-8)/\1/' /mnt/etc/locale.gen

sed -Ei 's/#(uk_UA.*UTF-8)/\1/' /mnt/etc/locale.gen

$root locale-gen



# Computer and user name
echo "archlinux" > /mnt/etc/hostname

echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 archlinux.localdomain archlinux" > /mnt/etc/hosts

$root printf "3556588\n3556588" | passwd

$root useradd -m alekuts

$root printf "3556588\n3556588" | passwd alekuts

$root usermod -aG wheel alekuts

$root export EDITOR=nvim

sed -Ei 's/# (%wheel ALL.*ALL\) ALL)/\1/' /mnt/etc/sudoers



# GRUB
$root mkdir /boot/EFI

diskPart=1

$root mount /dev/$disk$diskPart /boot/EFI

$root grub-install --target=x86_64-efi --efi-directory=/boot/EFI

$root grub-mkconfig -o /boot/grub/grub.cfg



# Xinit config
echo "xrandr --output DP-0 --mode 1920x1080 --rate 165" > /mnt/.xinitrc



# Unmount and reboot
umount /mnt -l

reboot
