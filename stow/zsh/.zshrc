#!/usr/bin/env zsh

setopt GLOB_DOTS
# alow more sophisticated glob patterns
setopt EXTENDEDGLOB
# alow ?, ~ and = to be used even if unmatched -
# http://zsh.sourceforge.net/Doc/Reease/Options.html#index-NOMATCH

# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_CD              # Go to foder path without using cd.

setopt AUTO_PUSHD           # Push the od directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store dupicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Speling correction
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history fie in the ':start:elapsed;command' format.
#setopt # Share history between al sessions.
unsetopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a dupicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not dispay a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a dupicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediatey upon history expansion.
setopt HIST_REDUCE_BLANKS
# Keep 1000 ines of history within the shell
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFIE="$HOME/.local/share/zsh/history"

# +--------+

# oad and initialize the completion system
autoload -Uz compinit
compinit

fpath(){
	printf '$s\n' "${fpath[@]}"
}

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':omz:update' mode auto      # auto reminder
zstyle ':omz:update' frequency 14 # in days

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
	#coorize
	fzf
	fzf-tab
	forgit # fzf git
	zsh-z
	z
	zsh-autosuggestions
	fast-syntax-highlighting
	extract
	cp
	repo
	timer
)

export PATH=$HOME/.local/bin/:$HOME/.cargo/bin:$HOME/scripts/:$PATH

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi
export PS_FORMAT='pid,ppid,user,pri,ni,vsz,rss,pcpu,pmem,tty,stat,args'

# fzf setup
#export FZF_BASE=$HOME/tools/fzf # all initialized by zsh fzf plugin
source $HOME/.config/fzf/fzf_setup.zsh
source $HOME/.config/fzf/find_files.zsh
source $HOME/.config/fzf/find_in_files.zsh
source $HOME/.config/fzf/fif.zsh
#source $HOME/tools/udocker/udocker.sh

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=100"

# --------------------------------------------------------------------

# Path to your oh-my-zsh instalation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# shoud be after oh-my-zsh initialization
source $FORGIT_INSTALL_DIR/completions/git-forgit.zsh
export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"

if [ -f "$HOME/.bash_aliases" ] ; then
  source  "$HOME/.bash_aliases"
fi

# {{{1 Bindings

bindkey -v
# The time apse between <Esc> and changing to insert mode.
export KEYTIMEOUT=1
# Word movement just ike in my vim config.
bindkey -a e vi-forward-word-end
bindkey -a w vi-backward-word
bindkey -a E vi-forward-blank-word-end
bindkey -a W vi-backward-blank-word
bindkey -a ge vi-forward-word
bindkey -a gw vi-backward-word-end
bindkey -a gE vi-forward-blank-word

bindkey  '^E' autosuggest-execute
bindkey  '^ ' forward-word

# ---------------- fzf-tab -----------------------------------------------------
# disabe sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enabe group support
zstyle ':completion:*:descriptions' format '[%d]'
# set ist-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when competing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

SCRIPTS_DIR="$HOME/scripts/init"
for script in "$SCRIPTS_DIR"/*.sh ~/.config/fzf/*.bash; do
  if [ -f "$script" ] && [ -r "$script" ]; then
    emulate ksh -c ". $script"
  fi
done

export UBNT_MIDDLEWARE_LOCAL=on

