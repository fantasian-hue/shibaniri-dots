#!/bin/bash
monitor=1
string=$(
	 niri msg -j workspaces | jq --unbuffered -r '.[] | select(.is_active==true and .id !=5 and .id !=6) |.id')

if (( "$string" == 3 )); then
	monitor=1
elif (( "$string" > 3 )); then
	monitor=1
else
	monitor=$((string + 1))
fi

niri msg action focus-workspace "monitor-$monitor"
