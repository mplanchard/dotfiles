# Set up a new MacOS system just the way I like it.

# Exit on error
set -e

# Constants
EMAIL="msplanchard@gmail.com"
GH_KEYFILE="$HOME/.ssh/github_rsa"
SSH_CONF="$HOME/.ssh/config"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Symlink Config files
[[ ! -f $HOME/.aliases ]] && ln -s "$SCRIPT_DIR/aliases.sh" "$HOME/.aliases"
[[ ! -f $HOME/.bash_profile ]] && ln -s "$SCRIPT_DIR/bash_profile.sh" "$HOME/.bash_profile"
[[ ! -f $HOME/.bashrc ]] && ln -s "$SCRIPT_DIR/bashrc.sh" "$HOME/.bashrc"
[[ ! -f $HOME/.globalrc ]] && ln -s "$SCRIPT_DIR/globalrc.sh" "$HOME/.globalrc"
[[ ! -f $HOME/.vimrc ]] && ln -s "$SCRIPT_DIR/vimrc" "$HOME/.vimrc"

# Install Homebrew and Command-line Tools
if [[ ! $(which brew) ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install packages from Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

brew update

BREW_PKGS="bash-completion \
    bat \
    exa \
    fd \
    git \
    mas \
    nvm \
    python3 \
    ripgrep \
    tokei \
    wget"

for PKG in $BREW_PKGS; do
    brew install $PKG || brew upgrade $PKG
done

[[ ! -d /Applications/Docker.app ]] && brew cask install docker
[[ ! -d /Applications/Dropbox.app ]] && brew cask install dropbox
[[ ! -d "/Applications/Firefox Developer Edition.app" ]] && brew cask install homebrew/cask-versions/firefox-developer-edition
[[ ! -d "/Applications/Firefox Nightly.app" ]] && brew cask install homebrew/cask-versions/firefox-nightly
[[ ! -d /Applications/Firefox.app ]] && brew cask install firefox
[[ ! -d "/Applications/Google Chrome.app" ]] && brew cask install google-chrome
[[ ! -d "/Applications/Backup and Sync.app" ]] && brew cask install google-photos-backup-and-sync
[[ ! -d /Applications/iTerm.app ]] && brew cask install iterm2
[[ ! -d /Applications/Slack.app ]] && brew cask install slack
[[ ! -d /Applications/Slack.app ]] && brew cask install slack
[[ ! -d /Applications/Virtualbox.app ]] && brew cask install virtualbox
[[ ! $(which vagrant) ]] && brew cask install vagrant
[[ ! -d "/Applications/Vagrant Manager.app" ]] && brew cask install vagrant-manager

unset HOMEBREW_NO_AUTO_UPDATE

# Install Rust
if [[ ! $(which rustc) ]]; then
    curl https://sh.rustup.rs -sSf | sh
fi

# Install Magnet from the app store
masid=$(mas search magnet | grep "Magnet (" | awk '{print $1}')
mas install "$masid"

# Install 1password from the app store
onepwid=$(mas search 1Password | grep "1Password 7 - Password Manager (" | awk '{print $1}')
mas install "$onepwid"

# Create a ~/tmp directory
mkdir -p $HOME/tmp

# Create a ~/.pyvenv directory
mkdir -p $HOME/.pyvenv

# Install virtualenv for python 3
/usr/local/bin/pip3 install virtualenv

# Create python vritual environments
[[ ! -d $HOME/.pyvenv/py3 ]] && /usr/local/bin/python3 -m venv $HOME/.pyvenv/py3
[[ ! -d $HOME/.pyvenv/py2 ]] && /usr/local/bin/virtualenv -p python2.7 $HOME/.pyvenv/py2

# Create a new SSH key for GitHub
if [[ ! -f "$GH_KEYFILE" ]]; then
    ssh-keygen \
        -t rsa \
        -b 4096 \
        -C "$EMAIL" \
        -f "$GH_KEYFILE" \
        -N ""
    CREATED_GH_KEY=1
    echo "Created a new SSH key for GH: $(cat $GH_KEYFILE.pub)"
else
    CREATED_GH_KEY=
fi

# Add it to the agent and keychain
eval "$(ssh-agent -s)"

# Create an SSH config if it doesn't exist
if [[ ! -f $SSH_CONF ]]; then
    touch "$SSH_CONF"
    echo "Created SSH config file"
else
    cp "$SSH_CONF" "$SSH_CONF.bak"
fi

# Check if we already have a Host * block. If not, write one
if [[ ! $(rg "Host \*" "$SSH_CONF") ]]; then
    cat << EOF >> "$SSH_CONF"
Host *
    AddKeysToAgent yes
    UseKeychain yes

EOF
    echo "Added global host entry to SSH config"
fi

# Check if we already have a GitHub block. If not, write one
if [[ ! $(rg "Host github.com" "$SSH_CONF") ]]; then
    cat << EOF >> "$SSH_CONF"
Host github.com
    IdentityFile $GH_KEYFILE

EOF
    echo "Added github.com host entry to SSH config"
fi

ssh-add -K $GH_KEYFILE

## GH Settings to add an SSH key
if [[ "$CREATED_GH_KEY" ]]; then
    open https://github.com/settings/keys
fi
