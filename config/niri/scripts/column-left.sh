#!/bin/bash

column_first=$(niri msg -j windows | jq --unbuffered -r '.[] | select(.is_focused==true) |.layout | .pos_in_scrolling_layout')
niri msg action move-column-left
column_last=$(niri msg -j windows | jq --unbuffered -r '.[] | select(.is_focused==true) |.layout | .pos_in_scrolling_layout')
if [ "$column_first" == "$column_last" ]; then
    niri msg action move-column-to-monitor-left
else
    exit
fi
