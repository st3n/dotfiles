#!/usr/bin/env zsh

# Ctrl-F (Find in Files)
RG_PREFIX='rg --column --line-number --no-heading --color=always --smart-case '
INITIAL_QUERY=''
FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY' $PWD"

__fif() {
    fzf --bind "change:reload:$RG_PREFIX {q} $PWD || true" --ansi --phony --query "$INITIAL_QUERY" | cut -d ':' -f1
}

find-in-files() {
  LBUFFER="${LBUFFER}$(__fif)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle -N find-in-files
bindkey '^F' find-in-files


#dynamically perform different actions depending on the state
fifp() {
fd --type file |
  fzf --prompt 'Files> ' \
      --header 'CTRL-T: Switch between Files/Directories' \
      --bind 'ctrl-t:transform:[[ ! {fzf:prompt} =~ Files ]] &&
              echo "change-prompt(Files> )+reload(fd --type file)" ||
              echo "change-prompt(Directories> )+reload(fd --type directory)"' \
      --preview '[[ {fzf:prompt} =~ Files ]] && bat --color=always {} || tree -C {}'
}


# 1. Search for text in files using Ripgrep
# 2. Interactively narrow down the list using fzf
# 3. Open the file in Vim
fife() {
   rg --color=always --line-number --no-heading --smart-case "${*:-}" |
      fzf --ansi \
         --color "hl:-1:underline,hl+:-1:underline:reverse" \
         --delimiter : \
         --preview 'bat --color=always {1} --highlight-line {2}' \
         --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
         --bind 'enter:become(vim {1} +{2})'
}


# Two-phase filtering with Ripgrep and fzf
#
# 1. Search for text in files using Ripgrep
# 2. Switch between Ripgrep launcher mode (CTRL-R) and fzf filtering mode (CTRL-F)
# 3. Open the file in Vim
# 4. To restore the query string when switching between modes, we store the current query in /tmp/rg-fzf-{r,f} files and restore
fifi() {
   rm -f /tmp/rg-fzf-{r,f}
   RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
   INITIAL_QUERY="${*:-}"
   : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
      --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --prompt '1. ripgrep> ' \
      --delimiter : \
      --header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(vim {1} +{2})'
 }
