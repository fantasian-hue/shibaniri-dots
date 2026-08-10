#!/bin/bash
#launch things on start, swaybg based on theme state

eww daemon
eww open bar
eww open cc-bg
eww open powermenu
eww open menu-killer
eww open menu-killer2

if [ "$(cat ~/.config/eww/scripts/theme-state)" = "pudding" ]; then
    swaybg -i /home/quokka/Documents/bg-tile.png -m fill
else
    swaybg -i /home/quokka/Documents/blue.png -m fill
fi
