#!/bin/bash

eww daemon && THEME=$(cat ~/.config/eww/scripts/theme-state 2>/dev/null) && eww update theme="$THEME"
eww open bar
eww open control-centre
eww open powermenu
eww open menu-killer
eww open menu-killer2

if [ "$(cat ~/.config/eww/scripts/theme-state)" = "light" ]; then
    swaybg -i /home/quokka/Downloads/bg.png -m fill
else
    swaybg -i /home/quokka/Downloads/bg2.png -m fill
fi


