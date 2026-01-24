#!/usr/bin/env bash

name="lutgen-video.sh"

# Check arguments
if [ "$#" -lt 2 ]; then
  echo "Usage: $name <input_video> <palette_name>"
  echo "Example: $name video.mp4 catppuccin-mocha"
  exit 1
fi

# Assign arguments
input="$1"
palette="$2"

# Derive names
base="${input%.*}"
ext="${input##*.}"
output="${base}_${palette}.${ext}"

lutgen generate -p "$palette" -o hald.png

ffmpeg -i "$input" -i hald.png \
  -filter_complex "[0][1] haldclut" \
  -c:v libx264 -crf 20 -pix_fmt yuv420p \
  "$output"

rm hald.png
