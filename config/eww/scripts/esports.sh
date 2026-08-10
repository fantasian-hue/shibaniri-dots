#!/bin/bash
#get current date and time, then read a massive calendar json file that is generated from leaguepedia. select the current date and only print out matches on that date

#time=$(jq -r --arg v "$DATE" --arg y "$SYSTIME" '.[] | select(.["Start Date"] == $v and .["Start Time"] > $y) | .["Start Time"]' ~/calendar.json)
#event=$(jq -r --arg v "$DATE" --arg y "$SYSTIME" '.[] | select(.["Start Date"] == $v and .["Start Time"] > $y) | .Subject' ~/calendar.json)

DATE=$(date +%F)
SYSTIME=$(date +%H:%M)



time=$(jq -r --arg v "$DATE" '.[] | select(.["Start Date"] == $v) | .["Start Time"]' ~/.config/eww/scripts/calendar.json)
event=$(jq -r --arg v "$DATE" '.[] | select(.["Start Date"] == $v) | .Subject' ~/.config/eww/scripts/calendar.json)
title=$(echo "$event" | awk '{print $(NF-2), $(NF-1), $NF}')

JSON_STRING=$( jq -n \
	--arg time "$time"\
	--arg title "$title"\
	'{time: $time, title: $title}')

echo $JSON_STRING
