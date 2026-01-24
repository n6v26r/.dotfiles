# Use powerline
# USE_POWERLINE="true"
# Source manjaro-zsh-configuration
# if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#   source /usr/share/zsh/manjaro-zsh-config
# fi

# Switched from p10k to starship
# Use manjaro zsh prompt
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi

. ~/.profile

# Theaming
export LS_COLORS="$(vivid generate catppuccin-mocha)"
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --multi"
export BAT_THEME="Catppuccin-mocha"

# Load prompt
eval "$(starship init zsh)"

# Transient prompt

zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  PROMPT='$(starship module time) $(starship module character)'
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}

zle -N zle-line-init

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# # Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# # Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit
compinit -d
colors

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait'0e' lucid atclone="mkdir ~/.config/fsh;cp ./themes/*.ini ~/.config/fsh/.;fast-theme XDG:catppuccin-mocha"
zinit light catppuccin/zsh-fsh

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload_history_substring_search_config

# Load completions

zinit cdreplay -q

## Keybindings section
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

zstyle ':completion:*' rehash true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Speed up
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# CUSTOM:
export EDITOR=hx
setopt +o nomatch
setopt GLOB_DOTS
setopt correct
setopt extendedglob
setopt nobeep
stty -ixon

#Better cat
alias cat="bat"

# Better ls
alias ls='exa --icons -F -H --group-directories-first --git -1'

## Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'

# alias r="ranger"
alias yz="yazi"
alias d="kitten diff"
alias n="nvim"
alias nv="neovim"
alias t="tmux"

alias ll="ls -l"
alias la="ls -a"

alias sudovim="sudo -E -s nvim"
alias wallpicker="yazi --chooser-file=>(xargs feh --bg-scale)"
alias hyprwall="yazi --chooser-file=>(xargs hyprctl hyprpaper reload ,)"

function pastebin() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs
    echo ""
}

# Fix some rendering issues with tui apps
function neomutt(){
  term=$TERM
  TERM=xterm-256color
  setterm -linewrap off
  /usr/bin/neomutt "$@"
  setterm -linewrap on
  TERM=$term
}

function nchat(){
  term=$TERM
  TERM=xterm-256color
  /usr/bin/nchat "$@"
  TERM=$term
}

function iplot {
  cat <<EOF | gnuplot
  set terminal svg enhanced
  set autoscale
  set size 1,1
  set samples 1000
  set output '|kitten icat --stdin yes'
  set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#eff1f5" behind
  plot $@
  set output '/dev/null'
EOF
}

function cava() {
  LC_ALL=en_US.UTF-8 /usr/bin/cava "$@"
}

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

###########

# ~/.local/share/asciiart/blocks1
