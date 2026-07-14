#!/bin/bash
#based off linkfrg mpris.sh

PLAYER="plasma-browser-integration"
echo {\"title\": \"\", \"artist\":\"\"}
playerctl -p "$PLAYER" metadata -F -f '{{title}} {{artist}} {{status}}' | while read -r line; do
	title=$(playerctl -p "$PLAYER" metadata -f "{{title}}")
	artist=$(playerctl -p "$PLAYER" metadata -f "{{artist}}")
	status=$(playerctl -p "$PLAYER" metadata -f "{{status}}")
	
	JSON_STRING=$( jq -n \
                --arg title "$title" \
                --arg artist "$artist"\
                --arg status "$status" \
                '{title: $title, artist: $artist, status: $status}' )
                
echo $JSON_STRING
done
