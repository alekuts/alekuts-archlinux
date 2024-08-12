#!/bin/bash



# Software
while ! pacman -Syu --noconfirm xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk pulseaudio pulseaudio-alsa alsa-utils fuse2 libmtp gvfs-mtp thunar thunar-archive-plugin xarchiver unzip flameshot firefox git steam wine wine-mono wine-gecko xfce4 xfce4-goodies rofi ; do : ; done



# Editor
EDITOR=nvim



# Xinit
printf "xrandr --output DP-0 --mode 1920x1080 --rate 165 &\nexec startxfce4" > /home/alekuts/.xinitrc



# Config files
cd /home/alekuts

git clone https://github.com/AleKutS/alekuts-archlinux

cd alekuts-archlinux

unzip .config.zip -d /home/alekuts/

cd ..

rm -rf alekuts-archlinux


# Exit from arch-chroot
exit
