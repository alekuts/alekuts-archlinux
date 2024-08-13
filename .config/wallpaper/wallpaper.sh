#!/bin/bash



source /home/alekuts/.config/wallpaper.cfg

if [ $w = 0 ]; then
  xrandr --output DP-0 --rotate normal && nitrogen --set-scaled /home/alekuts/.config/wallpaper/normal.jpg
else
  xrandr --output DP-0 --rotate right && nitrogen --set-scaled /home/alekuts/.config/wallpaper/right.jpeg
fi