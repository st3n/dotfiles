# Dotfiles

# HOWTO with stow
stow -nvS git -t ~/
use structure packaging in stow like in real HOME folder for created symlinks

# to get where diff-highlight in the system:
Fedora: rpm -ql git | grep diff-highlight
Debian/Ubuntu/Mint: dpkg -L git | grep diff-highlight
Archlinux: pacman -Ql git | grep diff-highlight


