#!/bin/bash
printf "PACMAN_AUTH=(doas)\n" | doas tee -a /etc/makepkg.conf

while ! doas pacman -Syu --noconfirm base-devel linux-headers go xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk pipewire pipewire-pulse pipewire-alsa pipewire-jack alsa-utils easyeffects lsp-plugins fuse2 libmtp gvfs-mtp thunar thunar-archive-plugin xarchiver 7zip kitty flameshot git steam wine zed fastfetch scrcpy kdenlive pavucontrol qpwgraph obs-studio telegram-desktop reaper duf compsize ntfs-3g btop rofi gammastep lxappearance rofi nvidia-utils mpv sxiv ; do : ; done

cd
while ! git clone https://aur.archlinux.org/yay.git ; do sleep 1 ; done
cd /home/alekuts/yay
while ! makepkg -si ; do sleep 1 ; done
yay --sudo doas --save
cd
while ! yay -S zen-browser-bin vesktop-bin awesome-git ; do sleep 1 ; done

while ! git clone https://github.com/alekuts/alekuts-archlinux ; do sleep 1 ; done

cp -rf ~/alekuts-archlinux/.config/. /home/alekuts/.config/
cp -f ~/alekuts-archlinux/.bashrc ~/.bashrc
cp -f ~/alekuts-archlinux/.xinitrc /home/alekuts/
mv ~/alekuts-archlinux/.themes /home/alekuts/
mv ~/alekuts-archlinux/.icons /home/alekuts/
mv ~/alekuts-archlinux/.vst3 /home/alekuts/
mv ~/alekuts-archlinux/wallpapers /home/alekuts/

rm -f postaalinux.sh
reboot
