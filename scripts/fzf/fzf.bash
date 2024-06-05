# Setup fzf
# ---------
if [[ ! "$PATH" == */home/igor/apps/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/igor/apps/fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/igor/apps/fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/igor/apps/fzf/shell/key-bindings.bash"
