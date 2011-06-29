setopt promptsubst

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="tordek"
export CASE_SENSITIVE="true"


source $ZSH/oh-my-zsh.sh

setopt interactivecomments
unsetopt autocd correctall cdablevars

# Customize to your needs...
export VISUAL=vim
export EDITOR=vim

alias git=git-achievements
alias gad=git add
alias gsta=git status
alias gci=git commit
alias gdf=git diff
alias gst=git stash -k
alias gffs=git flow feature start
alias gfff=git flow feature finish


fortune

echo
