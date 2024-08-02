#!/bin/bash



# Section 1
fdisk -l

read $disk

echo -e "g\nn\n\n\n+1G\nt\n1\nn\n\n\n+100G\nn\n\n\n\nw\nq" | fdisk -W always /dev/$disk

diskPart=1

mkfs.fat -F32 /dev/$disk$diskPart

diskPart=2

mkfs.ext4 /dev/$disk$dp

mount /dev/$disk$diskPart /mnt

diskPart=3

mkfs.ext4 /dev/$disk$diskPart

mkdir /mnt/home

mount /dev/$disk$diskPart /mnt/home



# Section 2
while ! pacstrap -K --noconfirm /mnt base linux linux-firmware ; do : ; done

genfstab /mnt -U >> /mnt/etc/fstab



# Section 3
root="arch-chroot /mnt"

$root pacman-key --init

$root pacman-key --populate

$root sed -Ei 's/#(\[multilib\])/\1/' /etc/pacman.conf

$root sed -i '/\[multilib\]/ {n;s/#//}' /etc/pacman.conf

$root while ! pacman -Syu --noconfirm dhcpcd sudo grub efibootmgr xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk font-manager pulseaudio pulseaudio-alsa alsa-utils fuse2 libmtp gvfs-mtp thunar flameshot git steam wine wine-mono wine-gecko nvidia ; do : ; done



# Section 4
$root systemctl enable dhcpcd

$root ln -sf /usr/share/zoneinfo/Europe/Kyiv /etc/localtime

$root hwclock --systohc

$root sed -Ei 's/#(de_DE.*UTF-8)/\1/' /etc/locale.gen

$root sed -Ei 's/#(en_US.*UTF-8)/\1/' /etc/locale.gen

$root sed -Ei 's/#(ja_JP.*UTF-8)/\1/' /etc/locale.gen

$root sed -Ei 's/#(uk_UA.*UTF-8)/\1/' /etc/locale.gen

$root locale-gen

$root echo "archlinux" > /etc/hostname

$root echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 archlinux.localdomain archlinux"

$root printf "3556588\n3556588" | passwd

$root useradd -m alekuts

$root printf "3556588\n3556588" | passwd alekuts

$root usermod -aG wheel alekuts

$root EDITOR=nvim

$root sed -Ei 's/# (%wheel ALL.*ALL\) ALL)/\1/' /etc/sudoers

$root mkdir /boot/EFI

$root diskPart=1

$root mount /dev/$disk$diskPart /boot/EFI

$root grub-install --target=x86_64-efi --efi-directory=/boot/EFI

$root grub-mkconfig -o /boot/grub/grub.cfg

umount /mnt -l

reboot
