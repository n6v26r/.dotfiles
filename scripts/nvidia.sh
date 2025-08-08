#!/bin/bash
# Add sudoers rule
sudo /usr/bin/nvidia-settings -l && sudo /usr/bin/nvidia-settings -a [GPU:0]/GPUFanControlState=1 && sudo /usr/bin/nvidia-settings -a [FAN:0]/GPUTargetFanSpeed=55
