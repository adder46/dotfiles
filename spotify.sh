#!/bin/bash

running="$(pidof spotify)"

if [[ ! -z "$running" ]]; then
    artist="$(playerctl metadata artist)"
    song="$(playerctl metadata title | cut -c 1-60)"
    printf "%s - %s\n" $artist $song
fi
