# RC file for all terminals


# Vim cmdline mode
set -o vi

# Source aliases
[ -f $HOME/.aliases ] && . $HOME/.aliases

# NVM setup
export NVM_DIR="$HOME/.nvm"
source "/usr/local/opt/nvm/nvm.sh"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# VSCode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

