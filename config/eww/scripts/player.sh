#!/bin/bash
#based off linkfrg mpris.sh

PLAYER="plasma-browser-integration"
echo {\"title\": \" - \"}
playerctl -p "$PLAYER" metadata -F -f '{{title}} {{artist}} {{status}}' | while read -r line; do
	title=$(playerctl -p "$PLAYER" metadata -f "{{title}}")
	artist=$(playerctl -p "$PLAYER" metadata -f "{{artist}}")
	status=$(playerctl -p "$PLAYER" metadata -f "{{status}}")
	text="$artist - $title"
	
	JSON_STRING=$( jq -n \
                --arg title "$text" \
                --arg status "$status" \
                '{title: $title, status: $status}' )
                
echo $JSON_STRING
done
