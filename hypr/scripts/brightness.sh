#!/bin/bash

brightness_notif () {
    brt_level=$(expr $(brightnessctl g) / 1200)

    # Send notification
    dunstify -a "brt_change" -u low  -h string:x-dunst-stack-tag:brt_change -h int:value:$brt_level -i "brt-$brt_level" "Brigthness: $brt_level%" 
}

brigthness_increase () {
    brightnessctl s +5%
}

brigthness_decrease () {
    brightnessctl s 5%-
}

case $1 in
    "0") 
        brigthness_decrease;
        ;;
    "1")
        brigthness_increase;
        ;;
esac

brightness_notif
