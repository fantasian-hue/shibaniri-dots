niri msg -j event-stream | jq --unbuffered -c 'select(.WindowFocusChanged) | .WindowFocusChanged.id' | while read -r id; do
	focused=$id
	if [ "$focused" == "null" ]; then

		echo $focused
	else

		echo $focused
	fi
done