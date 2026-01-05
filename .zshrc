zmodload zsh/zprof
set -o vi

if [[ -z $TERM ]] || ! infocmp "$TERM" >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

fpath=( ~/.zsh_functions "${fpath[@]}" )
autoload -U $fpath[1]/*(.:t)

# Enable history autocomplete.
autoload -U compinit 
compinit

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE

# HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
# END HISTORY

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward


# enable color support of ls and also add handy aliases
if [[ -x "$(command -v dircolors)" || -x "$(command -v gdircolors)" ]]; then
  if [ -x "$(command -v dircolors)" ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  else
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
  fi  
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias boot='mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && sdkman_debug_mode=FALSE source "$SDKMAN_DIR/bin/sdkman-init.sh"
export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

source ~/.zsh/plugins/zsh-z/zsh-z.plugin.sh

# git prompt options
# ...

# zsh-z plugin options
ZSH_CASE=smart # lower case patterns are treated as case insensitive
zstyle ':completion:*' menu select # improve completion menu style

#[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#[[ -s "/Users/mikeroberts/.gvm/scripts/gvm" ]] && source "/Users/mikeroberts/.gvm/scripts/gvm"
zprof
