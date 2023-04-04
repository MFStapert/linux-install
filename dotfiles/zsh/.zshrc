source $HOME/.asdf/asdf.sh
source $HOME/zsh/aliases

# JAVA HOME
. ~/.asdf/plugins/java/set-java-home.zsh


# GPG signing git commits
export GPG_TTY=$(tty)


bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

eval "$(starship init zsh)"

plugins=(
    asdf
    git
)

