#!/bin/bash

current_theme=$(cat "$HOME/.config/eww/scripts/theme-state")
new_theme=$(echo "$1")

if [ "$current_theme" = "$1" ]; then
    exit 0
else
    echo "$new_theme" > "$HOME/.config/eww/scripts/theme-state"
    if [ "$new_theme" = "seasalt" ]; then
        cp ~/.config/mozilla/firefox/c4iv4shh.default-release/chrome/seasalt.css ~/.config/mozilla/firefox/c4iv4shh.default-release/chrome/colours.css &
        cp ~/.config/gtk-4.0/seasalt.css ~/.config/gtk-4.0/colors.css &
        gsettings set org.gnome.desktop.interface gtk-theme 'seasalt' &
        gsettings set org.gnome.desktop.interface icon-theme 'adwaita' &
        pkill swaybg; swaybg -i /home/quokka/Documents/blue.png -m fill &
        cp ~/.cache/wal/seasalt.json ~/.cache/wal/colors.json &
        pywalfox update & ~/.config/zed/wal/pywal-to-zed.sh & theme-sync-update &
        cp ~/.config/alacritty/colors/seasalt.toml ~/.config/alacritty/colors.toml &
        cp ~/.config/niri/colours/seasalt.kdl ~/.config/niri/colors.kdl &
        eww update theme=seasalt &
        exit 0
    elif [ "$new_theme" = "pudding" ]; then
        cp ~/.config/mozilla/firefox/c4iv4shh.default-release/chrome/pudding.css ~/.config/mozilla/firefox/c4iv4shh.default-release/chrome/colours.css &
        cp ~/.config/gtk-4.0/pudding.css ~/.config/gtk-4.0/colors.css &
        gsettings set org.gnome.desktop.interface gtk-theme 'pudding' &
        gsettings set org.gnome.desktop.interface icon-theme 'pudding' &
        pkill swaybg; swaybg -i /home/quokka/Documents/bg-tile.png -m fill &
        cp ~/.cache/wal/pudding.json ~/.cache/wal/colors.json &
        pywalfox update & ~/.config/zed/wal/pywal-to-zed.sh & theme-sync-update &
        cp ~/.config/alacritty/colors/pudding.toml ~/.config/alacritty/colors.toml &
        cp ~/.config/niri/colours/pudding.kdl ~/.config/niri/colors.kdl &
        eww update theme=pudding &
        exit 0
    elif [ "$new_theme" = "pandan" ]; then
        cp ~/.config/mozilla/firefox/c4iv4shh.default-release/chrome/pudding.css ~/.config/mozilla/firefox/c4iv4shh.default-release/chrome/colours.css &
        cp ~/.config/gtk-4.0/pudding.css ~/.config/gtk-4.0/colors.css &
        gsettings set org.gnome.desktop.interface gtk-theme 'pudding' &
        gsettings set org.gnome.desktop.interface icon-theme 'pudding' &
        pkill swaybg; swaybg -i /home/quokka/Documents/bg-tile.png -m fill &
        cp ~/.cache/wal/pandan.json ~/.cache/wal/colors.json &
        pywalfox update & ~/.config/zed/wal/pywal-to-zed.sh & theme-sync-update &
        cp ~/.config/alacritty/colors/pandan.toml ~/.config/alacritty/colors.toml &
        cp ~/.config/niri/colours/light.kdl ~/.config/niri/colors.kdl &
        eww update theme=pandan &
        exit 0
    else
        exit 0
    fi
fi
