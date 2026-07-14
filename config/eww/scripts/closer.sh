#!/bin/bash
niri msg -j event-stream | jq --unbuffered -c 'select((.WindowFocusChanged | select(.id != null)), .WindowOpenedOrChanged, .WorkspaceActiveWindowChanged)' | while read -r _; do 
	eww update open_control=false && eww update open_powermenu=false
done

