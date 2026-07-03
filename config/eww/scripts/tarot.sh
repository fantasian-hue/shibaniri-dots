#!/bin/bash

deck="$(shuf -i 1-52)"
card="$(echo $deck | head -n 3)"
degree=$(((RANDOM % 2) + 1))

echo "$deck" | head -n 3
echo $degree
exit
