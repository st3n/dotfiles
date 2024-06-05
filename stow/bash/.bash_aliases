alias vim='nvim'
alias fd='fdfind'
alias zshconfig="vim ~/.zshrc"
alias lazy_nvimconfig="vim /home/igor/.local/share/nvim/lazy/LazyVim/"
alias nvimconfig="vim ~/.config/nvim"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias bathelp='bat --plain --language=help'
help() {
	"$@" --help | bathelp
}

alias -g -- -h="-h | bat --language=Manpage --style=plain"
alias -g -- --help="--help | bat --language=Manpage --style=plain"

alias ipp='curl https://ipecho.net/plain; echo'

alias pbcopy="xclip -sel clip"

alias labcollab_london='sudo openvpn --config ~/london-client.ovpn --auth-user-pass labcollab.pass --auth-retry interact'
alias labcollab_useast='sudo openvpn --config ~/useast.ovpn --auth-user-pass labcollab.pass --auth-retry interact'

alias mini_amba='minicom -D /dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DK0CYS10-if00-port0 -b 115200 -C $(date +'%Y-%m-%d-%T')-amba.txt'
alias mini_amba_2='minicom -D /dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DK0CZ2KQ-if00-port0 -b 115200 -C $(date +'%Y-%m-%d-%T')-amba2.txt'
alias mini_stm="minicom -D /dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DK0D14I9-if00-port0 -b 115200 -C $(date +"%Y-%m-%d-%T")-stm32.txt"
alias mini_stm_2="minicom -D /dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DK0CZ7CA-if00-port0 -b 115200 -C $(date +"%Y-%m-%d-%T")-stm32.txt"

alias mini_dialog="minicom -D /dev/serial/by-path/pci-0000:00:14.0-usb-0:2.2:1.0-port0 -b 115200 -C $(date +"%Y-%m-%d-%T")-dialog.txt"

alias mini_rasp="minicom -D /dev/serial/by-path/pci-0000:00:14.0-usb-0:13.3:1.0-port0 -b 115200 -C $(date +"%Y-%m-%d-%T")-raspberrypi.txt"

alias ll='exa -bghHlS'
alias as-tree='tree --fromfile'
