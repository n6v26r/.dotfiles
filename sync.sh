#! /usr/bin/env bash 

save=-1
folder=''

if [ "$1" == "save" ]; then
  save=1
elif [ "$1" == "load" ]; then
  save=0
fi;

if [ ! "$2" == "" ]; then
  folder=$2
fi;

declare -A sync
sync["mpv"]="configSync mpv"
sync["i3"]="configSync i3"
sync["nvim"]="configSync nvim"
sync["bat"]="configSync bat"
sync["conky"]="configSync conky"
sync["dunst"]="configSync dunst"
sync["ipython_config"]="configSync ipython_config.py config/ipython/profile_default ~/.config/ipython/profile_default"
sync["kitty"]="configSync kitty"
sync["picom"]="configSync picom"
sync["polybar"]="configSync polybar"
sync["zathura"]="configSync zathura"
sync["fastfetch"]="configSync fastfetch"
sync["cava"]="configSync cava"
sync["ranger"]="configSync ranger"
sync["yazi"]="configSync yazi"
sync["neofetch"]="# configSync neofetch"
sync["rofi"]="configSync rofi"
sync["tmux"]="configSync tmux/tmux.conf"
sync["starship"]="configSync starship"
sync[".zshrc"]="configSync .zshrc config/zsh ~"
sync[".zsh"]="configSync .zsh config/zsh ~"
sync[".gitconfig"]="configSync .gitconfig config ~"
sync["glow"]="configSync glow"
sync["dbxfs"]="configSync dbxfs"
sync["sc-im"]="configSync sc-im"
sync["imv"]="configSync imv"
sync["nchat"]="
  configSync app.conf config/nchat ~/.config/nchat ; 
  configSync color.conf config/nchat ~/.config/nchat ;
  configSync key.conf config/nchat ~/.config/nchat ;
  configSync ui.conf config/nchat ~/.config/nchat ;
  configSync usercolor.conf config/nchat ~/.config/nchat"

function configSync() {
  path1=config
  path2=~/.config
  if [ "$2" ]; then
    path1="$2"
    path2="$3"
  fi;
  
  if [ ! -e $path1/$1 ]; then
    if [ -d $path2/$1 ]; then
      mkdir -p $path1/$1
    else 
      mkdir -p $(dirname $path1/$1) && touch $path1/$1
    fi;
  fi;

  if [ ! -e $path2/$1 ]; then
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
    eval ${sync[$folder]}
  else
    for i in "${!sync[@]}"
    do
      eval ${sync[$i]}
    done
  fi;
fi;
