eval "$(starship init zsh)"

source $HOME/zsh/aliases

. $HOME/.asdf/asdf.sh

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

plugins=(
    asdf
    git
)