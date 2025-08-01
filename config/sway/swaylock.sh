#!/bin/sh

swaylock \
  --screenshots \
  --clock \
  --indicator \
  --indicator-radius 100 \
  --indicator-thickness 7 \
  --effect-blur 7x5 \
  --effect-vignette 0.5:0.5 \
  --grace 2 \
  --fade-in 0.2

# BLANK='#11111b'
# CLEAR='#11111b'
# DEFAULT='#b4befe'
# TEXT='#cdd6f4'
# WRONG='#f38ba8'
# VERIFYING='#a6e3a1'
#
# i3lock-color \
# --insidever-color=$CLEAR     \
# --ringver-color=$VERIFYING   \
# \
# --insidewrong-color=$CLEAR   \
# --ringwrong-color=$WRONG     \
# \
# --inside-color=$BLANK        \
# --ring-color=$DEFAULT        \
# --line-color=$BLANK          \
# --separator-color=$DEFAULT   \
# \
# --verif-color=$TEXT          \
# --wrong-color=$TEXT          \
# --time-color=$TEXT           \
# --date-color=$TEXT           \
# --layout-color=$TEXT         \
# --keyhl-color=$VERIFYING     \
# --bshl-color=$WRONG          \
# \
# --screen 1                   \
# --blur 5                     \
# --clock                      \
# --indicator                  \
# --time-str="%H:%M:%S"        \
# --date-str="%A, %Y-%m-%d"       \
# --keylayout 1                \
