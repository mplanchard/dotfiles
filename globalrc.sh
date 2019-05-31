# RC file for all terminals

# Ensure virtual envs are sourced in new shells
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# Set EDITOR
export EDITOR="nvim"

# Vim cmdline mode
set -o vi

# Direnv
eval "$(direnv hook bash)"

# GPG interactivity
export GPG_TTY=$(tty)

# Source aliases
[ -f $HOME/.aliases ] && . $HOME/.aliases

# NVM setup
export NVM_DIR="$HOME/.nvm"
source "/usr/local/opt/nvm/nvm.sh" 

# Brew
export PATH="/usr/local/bin:$PATH"


# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# VSCode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Source local RC

[ -f $HOME/.localrc ] && . $HOME/.localrc

