#!/bin/bash

while ! sudo pacman -Syu --noconfirm base-devel xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk pipewire pipewire-pulse pipewire-alsa alsa-utils easyeffects lsp-plugins fuse2 libmtp gvfs-mtp thunar thunar-archive-plugin xarchiver 7zip kitty flameshot git steam wine zed fastfetch scrcpy kdenlive pavucontrol qpwgrap obs-studio telegram-desktop reaper duf compsize ntfs3g btop awesome rofi gammastep lxappearance rofi nvidia nvidia-utils ; do : ; done

cd
while ! git clone https://aur.archlinux.org/yay.git ; do sleep 1 ; done
cd /home/alekuts/yay
makepkg -si
cd
yay -S zen-browser-bin vesktop-bin

mv alekuts-archlinux/.config /home/alekuts/
mv alekuts-archlinux/.themes /home/alekuts/
mv alekuts-archlinux/.icons /home/alekuts/
mv alekuts-archlinux/.xinitrc /home/alekuts/
mv alekuts-archlinux/.vst3 /home/alekuts/

rm postaalinux.sh
reboot
