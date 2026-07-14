#!/bin/bash

STATE="$HOME/.config/eww/scripts/theme-state"
CURRENT=$(cat "$STATE" 2>/dev/null || echo "light")

if [ "$CURRENT" = "light" ]; then
    NEW="dark"
else
    NEW="light"
fi

if [ "$NEW" = "light" ]; then
    dconf write /org/xfce/mousepad/preferences/view/color-scheme "'pudding'"
    gsettings set org.gnome.desktop.interface gtk-theme 'pudding'
    pkill swaybg; swaybg -i /home/quokka/Downloads/bg.png -m fill &
    cp ~/.config/alacritty/colors/"$NEW".toml \
   ~/.config/alacritty/colors.toml
    alacritty msg config "$(cat ~/.config/alacritty/colors.toml)"
    niri msg action load-config-file --path ~/.config/niri/config.kdl

else
    dconf write /org/xfce/mousepad/preferences/view/color-scheme "'pudding-dark'"
    gsettings set org.gnome.desktop.interface gtk-theme 'pudding-dark'
    pkill swaybg; swaybg -i /home/quokka/Downloads/bg2.png -m fill &
    cp ~/.config/alacritty/colors/"$NEW".toml \
   ~/.config/alacritty/colors.toml
    alacritty msg config "$(cat ~/.config/alacritty/colors.toml)"
    niri msg action load-config-file --path ~/.config/niri/dark.kdl
fi

echo "$NEW" > "$STATE"
printf "$NEW"
eww update theme="$NEW"
