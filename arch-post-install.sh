#!/bin/bash



# Software
while ! pacman -Syu --noconfirm xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk pulseaudio pulseaudio-alsa alsa-utils fuse2 libmtp gvfs-mtp thunar flameshot git steam wine wine-mono wine-gecko nvidia nvidia-settings ; do : ; done



# Editor
EDITOR=nvim



# Xinit
printf "xrandr --output DP-0 --mode 1920x1080 --rate 165 &" > /home/alekuts/.xinitrc



# Exit from arch-chroot
exit
