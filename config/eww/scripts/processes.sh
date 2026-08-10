#!/bin/sh
#get top cpu usage

while true; do
  pid_stream=$(pidstat 5 1 -o JSON | jq -c '.sysstat.hosts[0].statistics[0]["task-cpu-load"] | sort_by(.cpu) | reverse | .[0:5] | .[] | {cpu, cmd}')

cmd=$(echo $pid_stream | jq -r '.cmd')
cpu=$(echo $pid_stream | jq -r '.cpu')

JSON_STRING=$( jq -n \
	--arg cmd "$cmd"\
	--arg cpu "$cpu"\
	'{cmd: $cmd | gsub("\n"; "\\n"), cpu: $cpu | gsub("\n"; "\\n")}')
	echo $JSON_STRING 

done
