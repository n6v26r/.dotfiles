#!/bin/bash

switch_to_light_mode(){
  echo "include $HOME/.config/zathura/zathurarc-light" > $HOME/.config/zathura/zathurarc-theme
}

switch_to_dark_mode(){
  printf "# dark mode true\ninclude $HOME/.config/zathura/zathurarc-dark" > $HOME/.config/zathura/zathurarc-theme
}


if [[ $(grep -ic '# dark mode true' $HOME/.config/zathura/zathurarc-theme) -eq 1 ]]; then
  switch_to_light_mode
else
  switch_to_dark_mode
fi
