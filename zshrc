# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory autocd extendedglob
setopt HIST_IGNORE_DUPS
unsetopt beep

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mahmood/.zshrc'
fpath+=~/.zfunc

autoload -Uz compinit promptinit
compinit
promptinit
zstyle ':completion:*' menu select
setopt completealiases
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh
# End of lines added by compinstall
#

PATH=$PATH:~/bin:/home/mahmood/.cargo/bin:/home/mahmood/.local/bin:~/apps/flutter/bin

export PATH="$HOME/.cargo/bin:$PATH"
export VCPKG_ROOT=$HOME/vcpkg
export GOPATH=/home/mahmood/.config/go/
export VISUAL="vim"
export CHROME_EXECUTABLE=/opt/google/chrome/chrome
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export EDITOR=vim
export TERM=xterm-256color
export TERMINAL=wezterm

#
# HLEDGER FILE
export LEDGER_FILE=~/OneDrive/Documents/finance/2023.journal 
#
# Wasmer
export WASMER_DIR="/home/mahmood/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
[ -n "$TMUX" ] && export TERM=screen-256color
DEBIAN_PREVENT_KEYBOARD_CHANGES=yes
##
setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups
## This reverts the +/- operators.
setopt pushdminus

# NOTE: Alias does not work in .profile
alias pkgi="yay -Qq | fzf --preview 'yay -Qil {}' --height=97% --layout=reverse --bind 'enter:execute(yay -Qil {} | less)'"
alias vimbndl=~/Dropbox/configs/vim_bundle/bundle
alias lsh="ls -hl --color=auto"
alias notes="cd ~/Dropbox/notes/vimwiki/; vim index.md"
alias phpunittap="phpunit -vvv --color=always --tap"
alias jrnldate="date +\"%d %h, %a\""
alias taskcn="task context none"
alias t="task add"
alias u22="ssh 192.168.1.134"
alias crossroads="ssh 192.168.1.152"
## OH MY ZSH configs
# export ZSH=/usr/share/oh-my-zsh
# export ZSH_CUSTOM=~/.oh-my-zsh/
# export ZSH_CACHE_DIR=~/.oh-my-zsh/cache/
# plugins=(
#     git
#     poetry
# )
# AUTO_CD=false
# DISABLE_AUTO_UPDATE="true"
# source $ZSH/oh-my-zsh.sh

if [ -n "$JEDITERM_SOURCE" ]
then
  source $(echo $JEDITERM_SOURCE)
  unset JEDITERM_SOURCE
fi

_systemctl_unit_state() {
  typeset -gA _sys_unit_state
  _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') ) }

eval "$(direnv hook zsh)"
source /etc/profile.d/vte.sh

alias ls='eza -F=always -lh --color-scale --no-permissions --no-user'


eval "$(zoxide init zsh)"
# # fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /home/mahmood/.config/broot/launcher/bash/br
source /usr/share/nvm/init-nvm.sh
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# history things
eval "$(atuin init zsh)"

# env STARSHIP_LOG=trace starship module rust
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# the following line is required for startship, probably some misconfiguration
# above?
prompt off
eval "$(starship init zsh)"
