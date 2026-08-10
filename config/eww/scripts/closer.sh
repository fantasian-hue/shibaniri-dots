#!/bin/bash
#if the focus ever changes from an eww program, represented as .id = null, then send update to eww variables and close them

niri msg -j event-stream | jq --unbuffered -c 'select((.WindowFocusChanged | select(.id != null)), .WindowOpenedOrChanged, .WorkspaceActiveWindowChanged)' | while read -r _; do
	eww update open_control=false && eww update open_powermenu=false && eww close searchapps
done
