#/bin/sh

max_volume_pc=$1

current_volume_pc=$(pactl get-sink-volume @DEFAULT_SINK@ | grep 'Volume' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

echo $current_volume_pc

if (($(echo -n $current_volume_pc | wc -m) == 0)); then
    current_volume_pc=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
fi

if (($current_volume_pc < $max_volume_pc-10)) ; then
    pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
else
    a=$(($max_volume_pc - $current_volume_pc))
    pactl set-sink-volume @DEFAULT_SINK@ +$a% && $refresh_i3status
fi
