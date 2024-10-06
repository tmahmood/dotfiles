# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bash.bashrc
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# User specific aliases and functions

# Set $TERM for libvte terminals that set $TERM wrong (like gnome-terminal)
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
setopt HIST_IGNORE_DUPS
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mahmood/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
prompt walters
zstyle ':completion:*' menu select
setopt completealiases
source /usr/share/doc/pkgfile/command-not-found.zsh
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh


if [ -e /usr/share/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi

# End of lines added by compinstall
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh
{
  [ "_$TERM" = "_xterm" ] && type ldd && type grep && type tput && [ -L "/proc/$PPID/exe" ] && {
    if ldd /proc/$PPID/exe | grep libvte; then
      if [ "`tput -Tgnome-256color colors`" = "256" ]; then
        TERM=gnome-256color
      elif [ "`tput -Txterm-256color colors`" = "256" ]; then
        TERM=xterm-256color
      elif tput -T gnome; then
        TERM=gnome
      fi
    fi
  }
} >/dev/null 2>/dev/null

function get_pwd() {
	echo "${PWD/$HOME/~}"
}

# custom prompt
# [username] (jobs running) [current directory]
# #

RST='\[\e[0m\]'
BLA="\[\e[0;30m\]"
BLU="\[\e[0;34m\]"
GRN="\[\e[0;32m\]"
CYN="\[\e[0;36m\]"
RED="\[\e[0;31m\]"
PLE="\[\e[0;35m\]"
BRN="\[\e[0;33m\]"
LGR="\[\e[0;37m\]"
DGR="\[\e[1;30m\]"
LBL="\[\e[1;34m\]"
LGN="\[\e[1;32m\]"
LCN="\[\e[1;36m\]"
LRD="\[\e[1;31m\]"
LPE="\[\e[1;35m\]"
YLW="\[\e[1;33m\]"
WTE="\[\e[1;37m\]"

BLDBLK='\e[1;30m' # Black - Bold
BLDRED='\e[1;31m' # Red
BLDGRN='\e[1;32m' # Green
BLDYLW='\e[1;33m' # Yellow
BLDBLU='\e[1;34m' # Blue
BLDPUR='\e[1;35m' # Purple
BLDCYN='\e[1;36m' # Cyan
BLDWHT='\e[1;37m' # White

UNKBLK='\e[4;30m' # Black - Underline
UNDRED='\e[4;31m' # Red
UNDGRN='\e[4;32m' # Green
UNDYLW='\e[4;33m' # Yellow
UNDBLU='\e[4;34m' # Blue
UNDPUR='\e[4;35m' # Purple
UNDCYN='\e[4;36m' # Cyan
UNDWHT='\e[4;37m' # White

BAKBLK='\e[40m'   # Black - Background
BAKRED='\e[41m'   # Red
BADGRN='\e[42m'   # Green
BAKYLW='\e[43m'   # Yellow
BAKBLU='\e[44m'   # Blue
BAKPUR='\e[45m'   # Purple
BAKCYN='\e[46m'   # Cyan
BAKWHT='\e[47m'   # White

PATH=$PATH:~/bin

PROMPT_COMMAND=beforeprompt
TIME24=$(date +%H%M)
PS1="$DGR[$TIME24][\w] \$$RST "

if [[ $UID == 0 ]]; then
	PS1="$RED\u$RST \w \$RST"
fi


# little more information in ls
# alias ls="ls -o -F --group-directories-first -X -h"

# lists recently modified files
alias recent="ls -lAt| head"

alias dp="cd ~/Dropbox/projects"

# git related stuff, initialize and commits a git repository
alias gitme="git init; git add -A; git commit -m 'Rolling the project'"

alias ls='ls -h --color=auto --group-directories-first'

# be careful!
alias rd="rmdir"

# ignores duplicate commands
export HISTCONTROL=ignoredups

# ignore common commands
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear"

#
shopt -s histappend
PROMPT_COMMAND='history -a'
PATH=$PATH:~/bin

export HISTSIZE=10000
# set vi food for searching
set -o vi

export GREP_COLOR="1;33"
alias grep='grep --color=auto'


# Added by autojump install.sh
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

. /etc/profile.d/vte.sh

