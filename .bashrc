#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias ls='ls --color=auto'

# Load plugin
PLUGIN_PATH=$HOME/.config/bash/plugins

source $PLUGIN_PATH/git.plugin.sh

# XDG Envs
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config




#PS1='\e[38;5;227m\u@\h\e[0m \e[38;5;155m\w\e[0m $(git_for_ps1)\$ '
PS1='\u@\h \W\$ '

PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin:$HOME/.local/bin/

export WORKON_HOME=/home/rmarra/.envs/
export PROJECT_HOME=/home/rmarra/www/
source /home/rmarra/.local/bin/virtualenvwrapper.sh

alias vi=vim
alias vim=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export _JAVA_AWT_WM_NONREPARENTING=1

export PATH="$PATH:$HOME/go/bin"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
