# RC file for all terminals

# Set EDITOR
export EDITOR="vim"

# Vim cmdline mode
set -o vi

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

