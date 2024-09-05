#! /bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"
secinactive=0 # Number of seconds with no sound before the module hides

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/tmp/polybar_cava_config"
echo "
[general]
bars = 15

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
[input]
method = pulse
" > $config_file

time=$(( $(date +%s) - $secinactive ))
# read stdout from cava
cava -p $config_file | while read -r line; do
    visual=$(echo $line | sed $dict)
    if [[ ! -z "${visual//▁/}" ]]; then
        echo $visual
        time=$(date +%s)
    else
        if [[ $(date +%s) < $(( $time + secinactive )) ]]; then
            echo $visual 
        else
            echo ""
        fi;
    fi;
done
