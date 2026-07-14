#!/bin/sh
temp=$(sensors -j | jq -r '."k10temp-pci-00c3" | .Tctl | .temp1_input')
echo "$temp" | cut -c 1-4
