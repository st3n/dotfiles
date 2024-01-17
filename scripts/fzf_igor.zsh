export FD_OPTIONS="--follow --exclude .git --exclude node_modules"

export FZF_DEFAULT_OPTS="--no-mouse --height 80% --border --multi -- nline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always || cat {}) 2>/dev/null | head -300' --preview-window='right:hidden:wrap' --bind='ctrl-s:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"

export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l --hidden $FD_OPTIONS"

export FZF_CTRL_T_COMMAND='fd --hidden $FD_OPTIONS'
#export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!.git/*'"
export FZF_ALT_C_COMMAND="fd --type d --hidden $FD_OPTIONS"
export BAT_PAGER="less -R"

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-p:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-p:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

export FZF_TMUX_OPTS='-p80%,60%'

export FZF_COMPLETION_OPTS='--border --info=inline'

_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}
# export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# Configuring fuzzy completion
# https://github.com/junegunn/fzf#settings
_fzf_compgen_path() {
	#[[ ! -d "$1"/.git ]] && fd_flags="-I"
	fd --hidden --follow --exclude ".git" . "$1"
}

# Common fzf options to use in fuzzy completion
# export FZF_COMPLETION_OPTS=...

DEFAULT_PREVIEW='[[ -d {} ]] && exa -lF --group-directories-first --color=always {} || batcat -n --color=always {}'
# fzf options for each command
_fzf_comprun() {
	local command=$1
	shift
	case "$command" in
	cd) fzf --preview 'tree -C {} | head -200' "$@" ;;
	export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
	ssh) fzf --preview 'dig {}' "$@" ;;
	*) fzf --preview $DEFAULT_PREVIEW "$@" ;;
	esac
}

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

# +------+
# | tmux |
# +------+

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
function fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

# +-------+
# | Other |
# +-------+

# Search and find directories in the dir stack
fpop() {
    # Only work with alias d defined as:
    
    # alias d='dirs -v'
    # for index ({1..9}) alias "$index"="cd +${index}"; unset index

    d | fzf --height="20%" | cut -f 1 | source /dev/stdin

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

# Open pdf with Zathura
fpdf() {
    result=$(find -type f -name '*.pdf' | fzf --bind "ctrl-r:reload(find -type f -name '*.pdf')" --preview "pdftotext {} - | less")
    [ -n "$result" ] && nohup zathura "$result" &> /dev/null & disown
# List install files for dotfiles

fdot() {
    file=$(find "HOME/.config" -exec basename {} ';' | sort | uniq | nl | fzf | cut -f 2)
    [ -n "$file" ] && "$EDITOR" "$HOME/config/$file"
}

# List projects
fwork() {
    result=$(find ~/repo/* -type d -prune -exec basename {} ';' | sort | uniq | nl | fzf | cut -f 2)
    [ -n "$result" ] && cd ~/repo/$result
}

fcd() {
   selection=$(
      fd --type d | fzf --multi --height=80% --border=rounded \
         --preview='tree -C {}' --preview-window='60%,border-sharp' \
         --prompt='Dirs > ' \
         --bind='del:execute(rm -ri {+})' \
         --bind='ctrl-p:toggle-preview' \
         --bind='ctrl-d:change-prompt(Dirs > )' \
         --bind='ctrl-d:+reload(fd --type d)' \
         --bind='ctrl-d:+change-preview(tree -C {})' \
         --bind='ctrl-d:+refresh-preview' \
         --bind='ctrl-f:change-prompt(Files > )' \
         --bind='ctrl-f:+reload(fd --type f)' \
         --bind='ctrl-f:+change-preview(bat -f {})' \
         --bind='ctrl-f:+refresh-preview' \
         --bind='ctrl-a:select-all' \
         --bind='ctrl-x:deselect-all' \
         --header '
            CTRL-D to display directories | CTRL-F to display files
            CTRL-A to select all | CTRL-x to deselect all
            ENTER to edit | DEL to delete
            CTRL-P to toggle preview
         '
   )

if [ -d "$selection" ]; then
	cd "$selection" || exit
else
	eval "$EDITOR $selection"

}


