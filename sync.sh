#! /usr/bin/env bash 

save=-1
folder=''
folderpath=''
foldertopath=''

if [ "$1" == "save" ]; then
  save=1
elif [ "$1" == "load" ]; then
  save=0
fi;

if [ ! "$2" == "" ]; then
  folder=$2
  if [ ! "$3" == "" ]; then
    folderpath=$3
    foldertopath=$4
  fi;
fi;

if [ "$foldertopath" == '' ] && [ ! "$folderpath" == '' ]; then
  echo "Must provide system directory path"
  exit;
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
    read -p "Syncing $path1/$1 to $path2/$2. Proceed? (y/n) ";
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
  echo "Sync dots. Commands: save | load [dir] [dir on disk]"
  echo "Example: ./sync.sh load nvim # will load nvim config"
  echo "         ./sync.sh save      # will save all configs"
fi;
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! $folder == '' ]; then
    if [ ! $folderpath == '' ]; then
      configSync $folder $folderpath $foldertopath
    else
      configSync $folder
    fi;
  else
    configSync 'i3'
    configSync 'nvim'
    configSync 'bat'
    configSync 'conky'
    configSync 'dunst'
    configSync 'ipython_config.py' config/ipython/profile_default ~/.config/ipython/profile_default
    configSync 'kitty'
    configSync 'picom'
    configSync 'polybar'
    configSync 'zathura'
    configSync 'fastfetch'
    configSync 'cava'
    # configSync 'neofetch'
    configSync 'rofi'
    configSync 'tmux/tmux.conf'
    configSync 'starship.toml' config/starship ~/.config
    configSync '.zshrc' config/zsh ~
    configSync '.zsh' config/zsh ~
    configSync '.gitconfig' config ~
  fi;
fi;
