# #cuda setting
# export PATH=/usr/local/cuda-5.0/bin:${PATH}
# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda-5.0/lib64:/usr/local/cuda-5.0/lib
# export LIBRARY_PATH=/usr/lib/nvidia-current:$LIBRARY_PATH

export PATH=~/.local/bin:${PATH}
export PATH=~/bin/ovito-basic-3.7.2-x86_64/bin/:${PATH}

# color
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# prompt
PROMPT='%F{yellow}%n@%m%f:~$ '
RPROMPT="[%F{yellow}%d%f]:%m"

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct


# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

## Completion configuration
#
autoload -U compinit
compinit

## Doi added
setopt noauto_resume
setopt noauto_menu

## Alias configuration
#
# expand aliases before completing
#
# setopt complete_aliases # aliased ls needs if file/dir completions work


alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G -w"
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac

alias ls="ls --color"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias mmplayer='mplayer -geometry 300x200'

alias du="du -h"
alias df="df -h"
alias su="su -l"
alias disp_local='export DISPLAY=:1'
alias disp_remote='export DISPLAY=localhost:10.0'

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine


# End of lines added by compinstall


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias ssh='ssh -X'
    alias vi='vim'
    alias nvi='vim -u NONE -N'
    alias nnvi='vim -N'
    alias molden='molden -l'
    alias ctags='ctags-exuberant'
    alias cudactags='ctags --langmap=c++:+.cu *'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi


HISTSIZE=1000000
HISTFILESIZE=10000000

PATH="$HOME/bin:$PATH"

source ~/.zshrc_function

# git設定
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
PROMPT='%F{yellow}%n@%m%f '\$vcs_info_msg_0_':~$ '
RPROMPT="[%F{yellow}%d%f]:%m"
# PROMPT='%n@%m %c'\$vcs_info_msg_0_' %# '
precmd(){ vcs_info }

# フロー制御を行わない
setopt NO_flow_control

# pymol
#export LIBGL_ALWAYS_INDIRECT=1

export OMP_NUM_THREADS=2
export OMP_STACKSIZE=16G

## gaussian
#export g09root="/opt/g09/"
#export GAUSS_SCRDIR="/work/"
#export g09root GAUSS_SCRDIR
#. $g09root/g09/bsd/g09.profile
#
xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $display 2> /dev/null


source ~/bin/favdir/favdir.sh
source /opt/intel/oneapi/setvars.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/intel/oneapi/intelpython/latest/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/intel/oneapi/intelpython/latest/etc/profile.d/conda.sh" ]; then
        . "/opt/intel/oneapi/intelpython/latest/etc/profile.d/conda.sh"
    else
        export PATH="/opt/intel/oneapi/intelpython/latest/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# OCTA setting
export OCTA84_HOME=$HOME/OCTA84
export PATH=$OCTA84_HOME/GOURMET:$PATH
export MESA_GL_VERSION_OVERRIDE=3.0
export LC_CTYPE=ja_JP.UTF-8
