#!/usr/bin/env zsh

# Use bat consistently
alias bat='batcat'

# Default preview
export DEFAULT_PREVIEW='{ [[ -d {} ]] && exa -lF --group-directories-first --color=always "{}"; } || { bat --style=numbers --color=always "{}" || cat "{}"; }'

# Safe SEARCH_DEFAULT
export FD_OPTIONS="--strip-cwd-prefix --follow --exclude .git --exclude node_modules"
export FD_OPTIONS2="--strip-cwd-prefix --follow --exclude node_modules"
export FZF_DEFAULT_COMMAND="fdfind --type f --type l --hidden -I $FD_OPTIONS2"
# export FZF_DEFAULT_COMMAND='bash -c "git ls-files --cached --others --exclude-standard 2>/dev/null || fdfind --type f --type l --hidden -I $FD_OPTIONS"'

# FZF options

export FZF_DEFAULT_OPTS='
--height 80% --border --multi --inline-info
--preview "if file --mime {} | grep -q binary; then echo {} is a binary file; else (bat --style=numbers --color=always {} || cat {}); fi 2>/dev/null | head -500"
--preview-window="right:hidden:wrap"
--bind "ctrl-o:execute(nvim {} || less -f {}),ctrl-p:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)"
'

# CTRL-T
export FZF_CTRL_T_COMMAND="rg --files --no-ignore --hidden --follow --glob '!.git/*'"
export FZF_CTRL_T_OPTS="--preview '([ -f "{}" ] && (bat --style=numbers --color=always "{}" || cat "{}")) || ([ -d "{}" ] && tree -C -L 2 "{}")' --bind '?:toggle-preview'"

# ALT-C
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix"
export FZF_ALT_C_OPTS="--preview 'tree -C -L 2 "{}"'"

# Custom functions and commands for history, file navigation, etc.
fman() {
    man -k . | fzf -q "$1" --prompt='man> ' \
        --preview 'echo {} | tr -d "()" | awk "{print \$1}" | xargs -r man' \
        | tr -d '()' | awk '{print $1}' | xargs -r man
}

fpop() {
    d | fzf --height="20%" | cut -f 1 | source /dev/stdin
}

fcd() {
    local selection=$(fd --type d | fzf --multi --height=80% --border=rounded \
        --preview='tree -C {}' --preview-window='60%,border-sharp' \
        --prompt='Dirs > ' \
        --bind='del:execute(rm -ri {+})' \
        --bind='ctrl-p:toggle-preview' \
        --bind='ctrl-f:reload(fd --type f)' \
        --bind='ctrl-d:reload(fd --type d)' \
        --header '
            CTRL-D: show directories | CTRL-F: show files
            CTRL-P: toggle preview | DEL: delete selected files
            ENTER: open in editor' )

    [[ -d "$selection" ]] && cd "$selection" || eval "$EDITOR $selection"
}

rfv() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom' \
        --bind 'enter:become(nvim {1} +{2})'
}

fh() {
    (fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}

