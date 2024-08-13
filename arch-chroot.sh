#!/bin/bash



source variables



# Keys, multilib and software
pacman-key --init
pacman-key --populate

sed -Ei 's/#(\[multilib\])/\1/' /etc/pacman.conf
sed -i '/\[multilib\]/ {n;s/#//}' /etc/pacman.conf

while ! pacman -Syu --noconfirm dhcpcd sudo neovim grub efibootmgr ; do : ; done



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



# Hostname, root and user
printf "archlinux" > /etc/hostname

printf "127.0.0.1 localhost
::1 localhost
127.0.1.1 archlinux.localdomain archlinux" > /etc/hosts

printf "$password\n$password" | passwd

useradd -m alekuts

printf "$password\n$password" | passwd alekuts

usermod -aG wheel alekuts

sed -Ei 's/# (%wheel ALL.*ALL\) ALL)/\1/' /etc/sudoers



# GRUB
mkdir /boot/EFI

partNum=1
mount /dev/$disk$diskPart$partNum /boot/EFI

grub-install --target=x86_64-efi --efi-directory=/boot/EFI

grub-mkconfig -o /boot/grub/grub.cfg



# Moving post install script to user directory
mv arch-post-install.sh /home/alekuts/


# Delete script files
rm -rf arch-chroot.sh variables
