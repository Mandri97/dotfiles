#!/bin/bash

volume_notif () {
    vol_level=$(bc -q -l <<< "v=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2) * 100;scale=0; v/1")

    # Send notification
    dunstify -a "vol_change" -u low  -h string:x-dunst-stack-tag:vol_change -h int:value:$vol_level -i "volume-$vol_level" "Volume: $vol_level%" 
}

volume_up () {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
}

volume_down () {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
}

volume_mute () {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
}

case $1 in
    "0") 
        volume_down;
        ;;
    "1")
        volume_up;
        ;;
    *)
        volume_mute
        ;;
esac

volume_notif
