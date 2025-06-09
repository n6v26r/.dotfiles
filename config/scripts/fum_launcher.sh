#! /bin/bash

if  [ -z "$(xdotool search --classname 'fum')" ]; then
  kitty --detach --class "fum" -o "initial_window_height=250" -o "initial_window_width=550" -e fum

  sleep 0.5
  i3-msg "[instance=\"fum\"] move to scratchpad, scratchpad show"
else
  i3-msg "[instance=\"fum\"] scratchpad show"
fi
