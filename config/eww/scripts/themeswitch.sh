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

else
    dconf write /org/xfce/mousepad/preferences/view/color-scheme "'kate'"
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    pkill swaybg; swaybg -i /home/quokka/Downloads/bg2.png -m fill &
    cp ~/.config/alacritty/colors/"$NEW".toml \
   ~/.config/alacritty/colors.toml
    alacritty msg config "$(cat ~/.config/alacritty/colors.toml)"
fi

echo "$NEW" > "$STATE"
printf "$NEW"
eww update theme="$NEW"
