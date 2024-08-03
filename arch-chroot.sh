#!/bin/bash



# Programs
pacman-key --init

pacman-key --populate

sed -Ei 's/#(\[multilib\])/\1/' /etc/pacman.conf

sed -i '/\[multilib\]/ {n;s/#//}' /etc/pacman.conf

while ! pacman -Syu --noconfirm dhcpcd sudo grub efibootmgr xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk font-manager pulseaudio pulseaudio-alsa alsa-utils fuse2 libmtp gvfs-mtp thunar flameshot git steam wine wine-mono wine-gecko nvidia ; do : ; done



# Time
systemctl enable dhcpcd

ln -sf /usr/share/zoneinfo/Europe/Kyiv /etc/localtime

hwclock --systohc



# Locale
sed -Ei 's/#(de_DE.*UTF-8)/\1/' /etc/locale.gen

sed -Ei 's/#(en_US.*UTF-8)/\1/' /etc/locale.gen

sed -Ei 's/#(ja_JP.*UTF-8)/\1/' /etc/locale.gen

sed -Ei 's/#(uk_UA.*UTF-8)/\1/' /etc/locale.gen

locale-gen



# Computer and user name
echo "archlinux" > /etc/hostname

echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 archlinux.localdomain archlinux" > /etc/hosts

echo -e "3556588\n3556588" | passwd

useradd -m alekuts

echo -e "3556588\n3556588" | passwd alekuts

usermod -aG wheel alekuts

EDITOR=nvim

sed -Ei 's/# (%wheel ALL.*ALL\) ALL)/\1/' /etc/sudoers



# GRUB
mkdir /boot/EFI

diskPart=1

mount /dev/$disk$diskPart /boot/EFI

grub-install --target=x86_64-efi --efi-directory=/boot/EFI

grub-mkconfig -o /boot/grub/grub.cfg



# Xinit config
echo "xrandr --output DP-0 --mode 1920x1080 --rate 165" > .xinitrc



# Unmount and reboot
umount /mnt -l

reboot
