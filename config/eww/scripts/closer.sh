#!/bin/bash
niri msg -j event-stream | jq --unbuffered -c '.WindowFocusChanged | select(.id != null)' | while read -r _; do 
	eww update open_osd=false 
done
