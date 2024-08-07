#! /usr/bin/env bash 

save=-1
if [ "$1" == "save" ]; then
  save=1
elif [ "$1" == "load" ]; then
  save=0
fi;

function configSync() {
  path1=config
  path2=~/.config
  if [ "$2" ]; then
    path1="$2"
    path2="$3"
  fi;
  
  if [ ! -e $path1/$1 ]; then
    echo "1"
    if [ -d $path2/$1 ]; then
      mkdir -p $path1/$1
    else 
      mkdir -p $(dirname $path1/$1) && touch $path1/$1
    fi;
  fi;
 
  if [ ! -e $path2/$1 ]; then
    echo "1"
    if [ -d $path1/$1 ]; then
      mkdir -p $path2/$1
    else 
      mkdir -p $(dirname $path2/$1) && touch $path2/$1
    fi;
  fi;

  if [ "$(diff -r $path1/$1 $path2/$1)" ]; then
    diff -ru $path1/$1 $path2/$1
    read -p "Proceed? (y/n) ";
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      if [ $save == 1 ]; then
        rsync -av $path2/$1 $path1/
      elif [ $save == 0 ]; then
        rsync -av $path1/$1 $path2/
      fi;
    fi;
  fi;
}

if [ $save == 1 ]; then
  read -p "This will update your .dotfiles folder. Proceed? (y/n) ";
elif [ $save == 0 ]; then
  read -p "This will update your local configuration files. Proceed? (y/n) ";
else 
  echo "Sync dots. Commands: save | load"
fi;
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  configSync 'i3'
  configSync 'after' config/nvim  ~/.config/nvim
  configSync 'custom' config/nvim/lua ~/.config/nvim/lua
  configSync 'bat'
  configSync 'conky'
  configSync 'dunst'
  configSync 'ipython_config.py' config/ipython/profile_default ~/.config/ipython/profile_default
  configSync 'kitty'
  configSync 'picom'
  configSync 'neofetch'
  configSync 'polybar'
  configSync 'rofi'
  configSync 'tmux/tmux.conf'
  configSync 'starship.toml' config/starship ~/.config
  configSync '.zshrc' config/zsh ~
  configSync '.zsh' config/zsh ~
  configSync '.gitconfig' config ~
fi;
