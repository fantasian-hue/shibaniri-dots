# taken from isparsh and modified

#!/bin/sh
list=$(ls ~/.local/share/applications/ | grep "desktop" | grep -i "$1")
buf=""
for l in $list ; do
    t=$(echo $l | sed 's/.desktop//g' )
    buf="$buf (button :class { \"item \" + theme } :halign \"start\"  :onclick \" gtk-launch $l &\" \"$t\")"
done
echo "(box :orientation \"v\" :width 300 :class \"apps\" $buf)" > ~/.config/eww/scripts/search_items.txt
