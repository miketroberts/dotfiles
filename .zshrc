set -o vi

fpath=( ~/.zsh_functions "${fpath[@]}" )
autoload -U $fpath[1]/*(.:t)

eval "$(starship init zsh)"
