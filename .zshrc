# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/javier/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall
export TERM=xterm-256color

alias emacs='emacs -nw'
alias grep='grep --color=auto'

export EDITOR=emacs

autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%c %{$reset_color%}%% "
