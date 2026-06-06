#!/bin/bash

source /variables

while ! (pacman-key --init && pacman-key --populate) ; do sleep 1 ; done

sed -Ei 's/#(\[multilib\])/\1/' /etc/pacman.conf
sed -i '/\[multilib\]/ {n;s/#//}' /etc/pacman.conf

while ! pacman -Syu --noconfirm networkmanager opendoas neovim grub efibootmgr btrfs-progs ; do sleep 1 ; done

systemctl enable NetworkManager.service

ln -sf /usr/share/zoneinfo/Europe/Kyiv /etc/localtime
hwclock --systohc

sed -Ei 's/#(en_US.*UTF-8)/\1/' /etc/locale.gen
sed -Ei 's/#(uk_UA.*UTF-8)/\1/' /etc/locale.gen
locale-gen
printf "LANG=en_US.UTF-8" > /etc/locale.conf

printf "archlinux" > /etc/hostname

cat <<EOF > /etc/hosts
127.0.0.1 localhost
::1 localhost
127.0.1.1 archlinux.localdomain archlinux
EOF

echo "root:$PASSWORD" | chpasswd
useradd -m -G wheel alekuts
echo "alekuts:$PASSWORD" | chpasswd

touch /etc/doas.conf
printf "permit persist :wheel\n" > /etc/doas.conf
chown -c root:root /etc/doas.conf
chmod -c 0400 /etc/doas.conf

printf "zram\n" > /etc/modules-load.d/zram.conf
printf 'ACTION=="add", KERNEL=="zram0", ATTR{initstate}=="0", ATTR{comp_algorithm}="zstd", ATTR{disksize}="16G", TAG+="systemd"\n' > /etc/udev/rules.d/99-zram.rules
printf '/dev/zram0 none swap defaults,discard,pri=100,x-systemd.makefs 0 0\n' >> /etc/fstab

grub-install --target=x86_64-efi --efi-directory=/efi
grub-mkconfig -o /boot/grub/grub.cfg

mv postaalinux.sh /home/alekuts

rm chrootaalinux.sh variables
