source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Use powerline
# USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Switched from p10k to starship
# Use manjaro zsh prompt
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# PROMPT
eval "$(starship init zsh)"

# CUSTOM:

export EDITOR=nvim
setopt +o nomatch

#Better cat
export BAT_THEME="Catppuccin-mocha"
alias cat="bat"

# Better ls
alias ls='exa --icons -F -H --group-directories-first --git -1'

#Aliases
alias r="ranger"
alias n="nvim"
alias nv="neovim"
alias t="tmux"

alias ll="ls -l"
alias la="ls -a"

alias sudovim="sudo -E -s nvim"
# fix ctrl backaspace in tmux
bindkey '^H' backward-kill-word

function pastebin() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs
    echo "\n"
}

# use zoxide instead of cd
eval "$(zoxide init --cmd cd zsh)"
