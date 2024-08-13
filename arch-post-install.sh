#!/bin/bash



# Software
while ! sudo pacman -Syu --noconfirm xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk pulseaudio pulseaudio-alsa alsa-utils fuse2 libmtp gvfs-mtp thunar thunar-archive-plugin xarchiver unzip flameshot firefox git steam wine wine-mono wine-gecko xfce4 xfce4-goodies rofi ; do : ; done



# Editor
EDITOR=nvim



# Xinit
cd

printf "xrandr --output DP-0 --mode 1920x1080 --rate 165 &
exec startxfce4 &
flameshot" > .xinitrc



# Config files
while ! git clone https://github.com/AleKutS/alekuts-archlinux ; do : ; done

mv alekuts-archlinux/.config /home/alekuts/

rm -rf alekuts-archlinux arch-post-install.sh
