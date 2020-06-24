# source bashrc file
[[ -r $HOME/.bashrc ]] && source $HOME/.bashrc

[ -f $HOME/.local_profile ] && . $HOME/.local_profile

# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
if [ -e /Users/mplanchard/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/mplanchard/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
