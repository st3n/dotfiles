#!/usr/bin/env zsh

# Ctrl-F (Find in Files)
RG_PREFIX_2="rg --files --no-ignore --hidden --follow --glob '!.git/*'"

INITIAL_QUERY_2="${1:-""}"

#__ff() {
#    fzf --ansi --phony --query "$INITIAL_QUERY_2" --bind "change:reload:$RG_PREFIX_2 {q} $PWD || true" | cut -d ':' -f1
#}

__ff() {
    # Initial rg output is piped into fzf, and Ctrl-R binds to reload rg with the updated query
    eval "$RG_PREFIX_2" | fzf --bind "ctrl-r:reload:$RG_PREFIX_2 || true" \
        --ansi --query "$INITIAL_QUERY_2" --preview 'echo {}' | cut -d ':' -f1
}


find-files() {
  LBUFFER="${LBUFFER}$(__ff)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle -N find-files
bindkey '^P' find-files
