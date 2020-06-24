# RC file for bash


# Source global RC file
[[ -f $HOME/.globalrc ]] && source $HOME/.globalrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set prompt
export PS1="\[\033[38;5;13m\][\[$(tput sgr0)\]\[\033[38;5;10m\]\$?\[$(tput sgr0)\]\[\033[38;5;13m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;39m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;11m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput sgr0)\]"

# Enable bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Direnv support
eval "$(direnv hook bash)"

source /Users/mplanchard/.ghcup/env
source /Users/mplanchard/github/jwilm/alacritty/extra/completions/alacritty.bash
source /Users/mplanchard/.ghcup/env
