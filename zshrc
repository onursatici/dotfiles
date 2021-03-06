# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
export PROMPT='%B%F{yellow}$%f%b %B%F{white}%c%f%b '
export SPROMPT='zsh: correct %F{1}%R%f to %F{2}%r%f [nyae]? '

# history settings
setopt appendhistory histignoredups
setopt histignorespace extended_history
setopt INC_APPEND_HISTORY share_history
SAVEHIST=8096
HISTSIZE=8096

# Customize to your needs...
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# aliases
[[ -f ~/.aliases.zsh ]] && source ~/.aliases.zsh

set -o emacs

# make ag call tag by default
if (( $+commands[tag] )); then
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
fi

if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
fi

if (( $+commands[bat] )); then
  export BAT_THEME='base16'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS="--color=16"
  export FZF_ALT_C_COMMAND="fd -t d . . /Volumes/git"
fi
