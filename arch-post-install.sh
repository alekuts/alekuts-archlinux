#!/bin/bash



# Software
while ! sudo pacman -Syu --noconfirm base-devel xorg xorg-xinit noto-fonts noto-fonts-emoji noto-fonts-cjk pipewire pipewire-pulse pipewire-alsa alsa-utils easyeffects lsp-plugins fuse2 libmtp gvfs-mtp thunar thunar-archive-plugin xarchiver flameshot firefox git steam wine wine-mono wine-gecko xfce4 xfce4-goodies lxappearance rofi nvidia nvidia-settings ; do : ; done



# Config files
cd

while ! git clone https://github.com/AleKutS/alekuts-archlinux ; do : ; done

mv alekuts-archlinux/.config /home/alekuts/
mv alekuts-archlinux/.themes /home/alekuts/
mv alekuts-archlinux/.xinitrc /home/alekuts/



# Load easyeffects preset
easyeffects -l main



# Delete unnecessary software
sudo pacman -Rns --noconfirm xfce4-terminal xfce4-screenshooter
sudo pacman -Sc --noconfirm



# Self-delete
rm -rf arch-post-install.sh
