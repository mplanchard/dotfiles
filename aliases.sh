alias cat='bat'
alias cloc='tokei'
alias find='fd'
alias grep='rg'
alias ls='exa -F --group-directories-first'
alias ll='ls -lga@hF --git --group-directories-first'
alias rm='rm -i'

alias py3='source $HOME/.pyvenv/py3/bin/activate'
alias py2='source $HOME/.pyvenv/py2/bin/activate'

[[ -f "$HOME/.local_aliases" ]] && source "$HOME/.local_aliases"

