#!/bin/bash

# dropbox
# tmux rename-window -t 0 dropbox
#   tmux send-keys 'syncthing' C-m
#     tmux split-window -h
#     tmux select-pane -t:.+
#   tmux send-keys '~/.dropbox-dist/dropboxd' C-m

# monitor
function ssh_connecting {
tmux send-keys 'ssh '${1}'  ' C-m
tmux select-pane -t:.+
sleep 0.3s
}

function ssh_machine { # $1 : pane name, $2 command
tmux new-window -a -n ${1}
  tmux split-window
  tmux split-window -h
  tmux select-pane -t:.+
  tmux split-window -h
  tmux select-pane -t:.+
  ssh_connecting gingerb00
  ssh_connecting gingerb01
  ssh_connecting gingerb02
  ssh_connecting qnap
  tmux send-keys ${2}  C-m
}

ssh_machine monitor_htop 'htop'
ssh_machine monitor_df   'df -h | grep home'


tmux new-window -a -n main
tmux new-window -a -n admin


