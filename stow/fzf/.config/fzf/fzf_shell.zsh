#!/usr/bin/env zsh

# +-----+
# | Git |
# +-----+

# git log browser with FZF
fgl() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

fgb() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# +--------+
# | Pacman |
# +--------+

# TODO can improve that with a bind to switch to what was installed
fpac() {
    pacman -Slq | fzf --multi --reverse --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}

fyay() {
    yay -Slq | fzf --multi --reverse --preview 'yay -Si {1}' | xargs -ro yay -S
}

# +------+
# | tmux |
# +------+

fmux() {
    prj=$(find $XDG_CONFIG_HOME/tmuxp/ -execdir bash -c 'basename "${0%.*}"' {} ';' | sort | uniq | nl | fzf | cut -f 2)
    echo $prj
    [ -n "$prj" ] && tmuxp load $prj
}

# ftmuxp - propose every possible tmuxp session
ftmuxp() {
    if [[ -n $TMUX ]]; then
        return
    fi

    # get the IDs
    ID="$(ls $XDG_CONFIG_HOME/tmuxp | sed -e 's/\.yml$//')"
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi

    create_new_session="Create New Session"

    ID="${create_new_session}\n$ID"
    ID="$(echo $ID | fzf | cut -d: -f1)"

    if [[ "$ID" = "${create_new_session}" ]]; then
        tmux new-session
    elif [[ -n "$ID" ]]; then
        # Change name of urxvt tab to session name
        printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
        tmuxp load "$ID"
    fi
}

# ftmux - help you choose tmux sessions
ftmux() {
    if [[ ! -n $TMUX ]]; then
        # get the IDs
        ID="`tmux list-sessions`"
        if [[ -z "$ID" ]]; then
            tmux new-session
        fi
        create_new_session="Create New Session"
        ID="$ID\n${create_new_session}:"
        ID="`echo $ID | fzf | cut -d: -f1`"
        if [[ "$ID" = "${create_new_session}" ]]; then
            tmux new-session
        elif [[ -n "$ID" ]]; then
            printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
            tmux attach-session -t "$ID"
        else
            :  # Start terminal normally
        fi
    fi
}

# +-------+
# | Other |
# +-------+

# List install files for dotfiles
fdot() {
    file=$(find "$DOTFILES/install" -exec basename {} ';' | sort | uniq | nl | fzf | cut -f 2)
    [ -n "$file" ] && "$EDITOR" "$DOTFILES/install/$file"
}

# List projects
fwork() {
    result=$(find ~/workspace/* -type d -prune -exec basename {} ';' | sort | uniq | nl | fzf | cut -f 2)
    [ -n "$result" ] && cd ~/workspace/$result
}

# Open pdf with Zathura
fpdf() {
    result=$(find -type f -name '*.pdf' | fzf --bind "ctrl-r:reload(find -type f -name '*.pdf')" --preview "pdftotext {} - | less")
    [ -n "$result" ] && nohup zathura "$result" &> /dev/null & disown
}

# Open epubs with Zathura
fepub() {
    result=$(find -type f -name '*.epub' | fzf --bind "ctrl-r:reload(find -type f -name '*.epub')")
    [ -n "$result" ] && nohup zathura "$result" &> /dev/null & disown
}

# Open freemind mindmap
fmind() {
    local folders=("$CLOUD/knowledge_base" "$WORKSPACE/alexandria")

    files=""
    for root in ${folders[@]}; do
        files="$files $(find $root -name '*.mm')"
    done
    result=$(echo "$files" | fzf -m --height 60% --border sharp | tr -s "\n" " ")
    [ -n "$result" ] && nohup freemind $(echo $result) &> /dev/null & disown
}

# List tracking spreadsheets (productivity, money ...)
ftrack() {
    file=$(ls $CLOUD/tracking/**/*.{ods,csv} | fzf) || return
    [ -n "$file" ] && libreoffice "$file" &> /dev/null &
}

# Search and find directories in the dir stack
fpop() {
    # Only work with alias d defined as:
    
    # alias d='dirs -v'
    # for index ({1..9}) alias "$index"="cd +${index}"; unset index

    d | fzf --height="20%" | cut -f 1 | source /dev/stdin
}

# Find in File using ripgrep
fif() {
  if [ ! "$#" -gt 0 ]; then return 1; fi
  rg --files-with-matches --no-messages "$1" \
      | fzf --preview "highlight -O ansi -l {} 2> /dev/null \
      | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' \
      || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Find in file using ripgrep-all
fifa() {
    if [ ! "$#" -gt 0 ]; then return 1; fi
    local file
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$*" \
        | fzf-tmux -p +m --preview="rga --ignore-case --pretty --context 10 '"$*"' {}")" \
        && print -z "./$file" || return 1;
}

# Search through all man pages
function fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

