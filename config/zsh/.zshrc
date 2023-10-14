# The font used must be monospaced to make the distro iconlook ok

source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# CUSTOM:

export EDITOR=nvim
setopt +o nomatch # Disable pattern matching. (I can use gi now)

#Better cat
export BAT_THEME="Catppuccin-mocha"
alias cat="bat"

#Aliases
alias r="ranger"
alias n="nvim"
alias nv="neovim"
alias t="tmux"

alias ll="ls -l"
alias la="ls -a"
