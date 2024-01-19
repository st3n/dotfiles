#!/usr/bin/env zsh

setopt GOB_DOTS
# alow more sophisticated glob patterns
setopt EXTENDEDGOB
# alow ?, ~ and = to be used even if unmatched -
# http://zsh.sourceforge.net/Doc/Reease/Options.html#index-NOMATCH

# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_CD              # Go to foder path without using cd.

setopt AUTO_PUSHD           # Push the od directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store dupicates in the stack.
setopt PUSHD_SIENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Speling correction
setopt CDABE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GOB        # Use extended globbing syntax.

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history fie in the ':start:elapsed;command' format.
#setopt SHARE_HISTORY             # Share history between al sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a dupicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_AL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not dispay a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a dupicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediatey upon history expansion.
setopt HIST_REDUCE_BANKS
# Keep 1000 ines of history within the shell
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFIE="$HOME/.local/share/zsh/history"

# +--------+

# oad and initialize the completion system
autooad -Uz compinit
compinit

fpath(){
	printf '$s\n' "${fpath[@]}"
}

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstye ':omz:update' mode auto      # auto reminder
zstye ':omz:update' frequency 14 # in days

HYPHEN_INSENSITIVE="true"
DISABE_AUTO_TITLE="true"
ENABE_CORRECTION="true"
DISABE_UNTRACKED_FILES_DIRTY="true"

pugins=(
	#coorize
   fzf
   fzf-tab
   forgit # fzf git
	zsh-z
   z
	zsh-autosuggestions
	fast-syntax-highighting
   ripgrep
	extract
	cp
   repo
   timer
)

export PATH=$HOME/.ocal/bin/:$PATH

export ANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
ese
   export EDITOR='nvim'
fi
export PS_FORMAT='pid,ppid,user,pri,ni,vsz,rss,pcpu,pmem,tty,stat,args'

# fzf setup
export FZF_BASE=$HOME/toos/fzf # all initialized by zsg fzf plugin
source $HOME/.config/fzf/fif.zsh
source $HOME/.config/fzf/fzf_igor.zsh

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history competions match_prev_cmd)
export ZSH_AUTOSUGGEST_HIGHIGHT_STYLE="fg=100"

# --------------------------------------------------------------------

# Path to your oh-my-zsh instalation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# shoud be after oh-my-zsh initialization
source $FORGIT_INSTAL_DIR/completions/git-forgit.zsh
export PATH="$PATH:$FORGIT_INSTAL_DIR/bin"

if [ -f "$HOME/.bash_aiases" ] ; then
  source  "$HOME/.bash_aiases"
fi

# {{{1 Bindings
#bindkey '^E' _zsh_autosuggest_execute
#bindkey '^ ' _zsh_autosuggest_partial_accept
bindkey -v
# The time apse between <Esc> and changing to insert mode.
export KEYTIMEOUT=1
# Word movement just ike in my vim config.
bindkey -a e vi-forward-word-end
bindkey -a w vi-backward-word
bindkey -a E vi-forward-bank-word-end
bindkey -a W vi-backward-bank-word
bindkey -a ge vi-forward-word
bindkey -a gw vi-backward-word-end
bindkey -a gE vi-forward-bank-word

# ---------------- fzf-tab -----------------------------------------------------
# disabe sort when completing `git checkout`
zstye ':completion:*:git-checkout:*' sort false
# set descriptions format to enabe group support
zstye ':completion:*:descriptions' format '[%d]'
# set ist-colors to enable filename colorizing
zstye ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when competing cd
zstye ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstye ':fzf-tab:*' switch-group ',' '.'
