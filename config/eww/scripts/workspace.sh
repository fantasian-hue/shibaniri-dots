#!/bin/bash
niri msg -j workspaces | jq --unbuffered -r '.[] | select(.is_active==true and .output=="HDMI-A-2") | .name'

niri msg -j event-stream | jq --unbuffered -c 'select(.WorkspaceActivated)' | while read -r line; do
        niri msg -j workspaces | jq --unbuffered -r '.[] | select(.is_active==true and .output=="HDMI-A-2") | .name'
done
