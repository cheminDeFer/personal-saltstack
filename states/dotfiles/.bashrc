shopt -s autocd
stty -ixon
alias emacs='emacs -nw'
HISTIGNORE='c:ls:[ \t]*'
alias c='clear'
alias shutdown='shutdown now'
alias ls='ls --color -lah'
export GOROOT=${HOME}/.local/go
export GOPATH=${HOME}/go
export PATH=${PATH}:${GOROOT}/bin
export PATH=${PATH}:${GOPATH}/bin
export PATH=:${HOME}/bin:${PATH}
set -o vi
PS1="\[\033[1;32m\]\u@\h:\[\033[34m\]\w\[\033[0m\]\n\$ "
