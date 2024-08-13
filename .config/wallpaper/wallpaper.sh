#!/bin/bash



source /home/alekuts/.config/wallpaper/wallpaper.cfg

if [ $w = 0 ]; then
  xrandr --output $dp --rotate normal && nitrogen --set-scaled /home/alekuts/.config/wallpaper/normal.jpg
else
  xrandr --output $dp --rotate right && nitrogen --set-scaled /home/alekuts/.config/wallpaper/right.jpeg
fi
