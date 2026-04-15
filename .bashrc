# If not running interactively, don't do anything
[[ $- != *i* ]] && return


cyan='\033[1;36m'
green='\033[1;32m'
off='\033[0m'

PS1="\[${cyan}\]alekuts\[${off}\] \t \[${green}\]\w/\[${off}\]\n > "

alias l='ls -aF'
alias c='clear'
alias e='exit'
alias mr='cd alekuts-archlinux'
