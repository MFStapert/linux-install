#plugins
# source $HOME/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

source $HOME/zsh/aliases

. $HOME/.asdf/asdf.sh

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

eval "$(starship init zsh)"

plugins=(
    asdf
    git
)

