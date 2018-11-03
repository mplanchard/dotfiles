# Set up a new MacOS system just the way I like it.

# Exit on error
set -e

# Constants
EMAIL="msplanchard@gmail.com"
GH_KEYFILE="$HOME/.ssh/github_rsa"
SSH_CONF="$HOME/.ssh/config"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# ###################################################################### 
# Add Config Files
# ###################################################################### 

[[ ! -f $HOME/.aliases ]] \
    && echo "linking alises" \
    && ln -s "$SCRIPT_DIR/aliases.sh" "$HOME/.aliases"
[[ ! -f $HOME/.bash_profile ]] \
    && echo "linking bash_profile" \
    && ln -s "$SCRIPT_DIR/bash_profile.sh" "$HOME/.bash_profile"
[[ ! -f $HOME/.bashrc ]] \
    && echo "linking bashrc" \
    && ln -s "$SCRIPT_DIR/bashrc.sh" "$HOME/.bashrc"
[[ ! -f $HOME/.globalrc ]] \
    && echo "linking globalrc" && ln -s "$SCRIPT_DIR/globalrc.sh" "$HOME/.globalrc"
[[ ! -f $HOME/.vimrc ]] \
    && echo "linking vimrc" \
    && ln -s "$SCRIPT_DIR/vimrc" "$HOME/.vimrc"

# ###################################################################### 
# Install Things
# ###################################################################### 

# **********************************************************************
# Vim plugins
# **********************************************************************

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

PLUGINS="editorconfig/editorconfig-vim \
    ekalinin/dockerfile.vim \
    elzr/vim-json \
    joshdick/onedark.vim \
    kien/ctrlp.vim \
    leafgarland/typescript-vim \
    mxw/vim-jsx \
    nathanaelkane/vim-indent-guides \
    pangloss/vim-javascript \
    rust-lang/rust.vim \
    scrooloose/nerdtree \
    w0rp/ale" 

for PLUGIN in $PLUGINS; do
    NAME=$(basename "$PLUGIN")
    echo "checking vim plugin $NAME"
    if [[ ! -d $HOME/.vim/bundle/$NAME ]]; then
        git clone https://github.com/$PLUGIN.git $HOME/.vim/bundle/$NAME
    else
        (cd $HOME/.vim/bundle/$NAME && git pull)
    fi
done

# **********************************************************************
# Other stuff
# **********************************************************************

# Install Homebrew and Command-line Tools
if [[ ! $(which brew) ]]; then
    echo "installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Try to update xcode cli tools
if [[ ! $(xcode-select --version) ]]; then
    xcode-select --install
fi

# Install packages from Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

brew update

BREW_PKGS=" \
    bash-completion \
    bat \
    exa \
    fd \
    git \
    mas \
    nvm \
    python3 \
    ripgrep \
    tokei \
    vim \
    wget"

echo "checking brew packages for installs or updates"

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
[[ ! -d "/Applications/Visual Studio Code.app" ]] && brew cask install visual-studio-code

unset HOMEBREW_NO_AUTO_UPDATE

# Install Rust
if [[ ! $(which rustc) ]]; then
    echo "installing rust"
    curl https://sh.rustup.rs -sSf | sh
fi

# Temporarily disabled due to this bug: 
#   https://github.com/mas-cli/mas/issues/182
# Install Magnet from the app store
# echo "checking magnet install"
# MAGNET_ID=$(mas search magnet | grep "Magnet (" | awk '{print $1}')
# mas install "$MAGNET_ID"
# 
# # Install 1password from the app store
# echo "checking 1password install"
# ONEPW_ID=$(mas search 1Password | grep "1Password 7 - Password Manager (" | awk '{print $1}')
# mas install "$ONEPW_ID"
# 
# # Install amphetamine
# echo "checking amphetamine install"
# AMPHETAMINE_ID=$(mas search Amphetamine | grep "Amphetamine (" | awk '{print $1}')
# mas install "$AMPHETAMINE_ID"

# ###################################################################### 
# Configure VSCode
# ###################################################################### 

CODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
INSTALLED_EXTENSIONS=$("$CODE" --list-extensions)
TO_INSTALL=" \
    bungcip.better-toml \
    DavidAnson.vscode-markdownlint \
    dbaeumer.vscode-eslint \
    eamodio.gitlens \
    eg2.tslint \
    eg2.vscode-npm-script \
    HookyQR.beautify \
    marcostazi.VS-code-vagrantfile \
    ms-python.python \
    ms-vscode.cpptools \
    PeterJausovec.vscode-docker \
    redhat.vscode-yaml \
    robertohuertasm.vscode-icons \
    rust-lang.rust \
    streetsidesoftware.code-spell-checker \
    vadimcn.vscode-lldb \
    vscode-ext.sync-rsync \
    vscodevim.vim"

echo "installing vscode extensions"

for EXTENSION in $TO_INSTALL; do
    echo "$EXTENSION"
    if [[ ! $(grep "$EXTENSION" <<< "$INSTALLED_EXTENSIONS") ]]; then
        "$CODE" --install-extension "$EXTENSION"
    fi
done

# Add user settings
mkdir -p "$HOME/github/mplanchard"

[[ ! -d "$HOME/github/mplanchard/vscode-settings" ]] \
    && echo "checking out vscode-settings" \
    && git clone https://github.com/mplanchard/vscode-settings "$HOME/github/mplanchard/vscode-settings"

(cd $HOME/github/mplanchard/vscode-settings && git checkout master && git pull)

SETTINGS_DIR="$HOME/Library/Application Support/Code/User"

mkdir -p "$SETTINGS_DIR"

SETTINGS_FILE="$SETTINGS_DIR/settings.json"

[[ ! -f "$SETTINGS_FILE" ]] \
    && echo "updating user settings for vscode" \
    && ln -s "$HOME/github/mplanchard/vscode-settings/user-settings.json" "$SETTINGS_FILE"

# ###################################################################### 
# Add useful directories
# ###################################################################### 

# Create a ~/tmp directory
mkdir -p $HOME/tmp

# ###################################################################### 
# Install Python venvs
# ###################################################################### 

# Create a ~/.pyvenv directory
mkdir -p $HOME/.pyvenv

# Install virtualenv for python 3
/usr/local/bin/pip3 install virtualenv

# Create python vritual environments
[[ ! -d $HOME/.pyvenv/py3 ]] \
    && echo "creating python3 venv" \
    && /usr/local/bin/python3 -m venv $HOME/.pyvenv/py3
[[ ! -d $HOME/.pyvenv/py2 ]] \
    && echo "creating python2 venv" \
    && /usr/local/bin/virtualenv -p python2.7 $HOME/.pyvenv/py2

# Install dev packages

TO_INSTALL_ALL=" \
    flake8 \
    ipdb \
    pydocstyle \
    pylint \
    pytest"
TO_INSTALL_PY2=" \
    mock \
    six \
    typing"
TO_INSTALL_PY3=" \
    mypy"

echo "checking python3 packages"

$HOME/.pyvenv/py3/bin/pip install $TO_INSTALL_ALL
$HOME/.pyvenv/py3/bin/pip install $TO_INSTALL_PY3

echo "checking python2 packages"

$HOME/.pyvenv/py2/bin/pip install $TO_INSTALL_ALL
$HOME/.pyvenv/py2/bin/pip install $TO_INSTALL_PY2


# ###################################################################### 
# Configure git
# ###################################################################### 

# Add `git lg` alias

git config --global alias.lg " \
    log \
    --color \
    --graph \
    --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' \ 
    --abbrev-commit"

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

