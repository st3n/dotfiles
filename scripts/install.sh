#!/bin/bash

# install zsh
sudo apt install -y zsh

#--------------
#
# install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#--------------
#
# install zsh-autocomplete
GITHUB_USER="marlonrichert"
GITHUB_REPO="zsh-autocomplete"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${GITHUB_REPO}

git clone ${SOURCE} ${TARGET}

#--------------
#
# install zsh-z
GITHUB_USER="agkozak"
GITHUB_REPO="zsh-z"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${GITHUB_REPO}

git clone ${SOURCE} ${TARGET}

#--------------
#
# install zsh-syntax-highlighting
GITHUB_USER="zsh-users"
GITHUB_REPO="zsh-syntax-highlighting"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${GITHUB_REPO}

git clone ${SOURCE} ${TARGET}

#--------------
#
# install zsh-autosuggestions

GITHUB_USER="zsh-users"
GITHUB_REPO="zsh-autosuggestions"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${GITHUB_REPO}

git clone ${SOURCE} ${TARGET}
#--------------
#
# install p10k
GITHUB_USER="romkatv"
GITHUB_REPO="powerlevel10k"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/${GITHUB_REPO}

git clone --depth=1 ${SOURCE} ${TARGET}

#--------------

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  
git clone https://github.com/wfxr/forgit.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit
