alias vim='nvim'
alias vi='nvim'
#alias fd='fdfind'
alias zshconfig="vim ~/.zshrc"
alias lazy_nvimconfig="vim /home/igor/.local/share/nvim/lazy/LazyVim/"
alias nvimconfig="vim ~/.config/nvim"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias bathelp='bat --plain --language=help'
help() {
  "$@" --help | bathelp
}

#alias -g -- -h="-h | bat --language=Manpage --style=plain"
#alias -g -- --help="--help | bat --language=Manpage --style=plain"

alias ipp='curl https://ipecho.net/plain; echo'

alias pbcopy="xclip -sel clip"

alias mini_amba='minicom -D /dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DK0CYS10-if00-port0 -b 115200 -C $(date +'%Y-%m-%d-%T')-amba.txt'
alias mini_amba_2='minicom -D /dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DK0CZ2KQ-if00-port0 -b 115200 -C $(date +'%Y-%m-%d-%T')-amba2.txt'
alias mini_stm="minicom -D /dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DK0D14I9-if00-port0 -b 115200 -C $(date +"%Y-%m-%d-%T")-stm32.txt"
alias mini_stm_2="minicom -D /dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DK0CZ7CA-if00-port0 -b 115200 -C $(date +"%Y-%m-%d-%T")-stm32.txt"

alias mini_dialog="minicom -D /dev/serial/by-path/pci-0000:00:14.0-usb-0:2.2:1.0-port0 -b 115200 -C $(date +"%Y-%m-%d-%T")-dialog.txt"

alias mini_rasp5="sudo minicom -D /dev/serial/by-id/usb-Raspberry_Pi_Debug_Probe__CMSIS-DAP__E6633861A32D992C-if01 -b 115200 -C $(date +"%Y-%m-%d-%T")-raspberrypi.txt"
alias mini_rasp4="sudo minicom -D  /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A50285BI-if00-port0 -b 115200 -C $(date +"%Y-%m-%d-%T")-raspberrypi.txt"
alias mini_cm5="sudo minicom -D /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A50285BI-if00-port0  -b 115200 -C $(date +"%Y-%m-%d-%T")-raspberrypi.txt"

alias ll='eza -bghHlS'
alias as-tree='tree --fromfile'

export UBNT_FW_CACHE=$HOME/.ubnt/cache

alias glinfo='glxinfo | grep -e OpenGL.vendor -e OpenGL.renderer'

# Detect which `ls` flavor is in use
if ls --color >/dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# List only directories
alias lsd='ls -l | grep "^d"'

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
alias makectags='ctags -R --c++-kinds=+p --fields=+iaS --extras=+q /usr/include'
alias fd='fdfind'
alias bat='batcat' # if your system only has batcat
