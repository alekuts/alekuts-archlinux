#!/bin/bash



# Software
while ! sudo pacman -Syu --noconfirm xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk pulseaudio pulseaudio-alsa alsa-utils fuse2 libmtp gvfs-mtp thunar thunar-archive-plugin xarchiver flameshot firefox git steam wine wine-mono wine-gecko xfce4 xfce4-goodies lxappearance rofi nvidia nvidia-settings ; do : ; done

sudo pacman -Rns --noconfirm xfce4-terminal xfce4-screenshooter
printf "\n\n" | pacman -Sc --noconfirm



# Config files
cd

while ! git clone https://github.com/AleKutS/alekuts-archlinux ; do : ; done

mv alekuts-archlinux/.config /home/alekuts/
mv alekuts-archlinux/.themes /home/alekuts/
mv alekuts-archlinux/.xinitrc /home/alekuts/



# Delete unnecessary software
sudo pacman -Rns --noconfirm xfce4-terminal xfce4-screenshooter

printf "\n\n" | pacman -Sc --noconfirm



# Self-delete
rm -rf alekuts-archlinux arch-post-install.sh
