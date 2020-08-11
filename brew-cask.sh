#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`


# Install native apps

brew install caskroom/cask/brew-cask
# brew tap caskroom/versions
# Get package names from https://formulae.brew.sh/cask/jetbrains-toolbox#default

# daily
brew cask install spectacle
brew cask install dropbox
brew cask install google-drive-file-stream # for team
brew cask install google-backup-and-sync
brew cask install 1password
brew cask install cleanmymac
brew cask install slack
brew cask install alfred
brew cask install boostnote
brew cask install notion
brew cask install kap
brew cask install google-chrome
brew cask install firefox

# dev
brew cask install iterm2
brew cask install docker
brew cask install hyper
brew cask install sublime-text
brew cask install visual-studio-code
brew cask install jetbrains-toolbox
brew cask install pycharm
brew cask install macvim
brew cask install imagealpha
brew cask install imageoptim
brew cask install pixelsnap

# less often
brew cask install disk-inventory-x
brew cask install screenflow
brew cask install vlc
brew cask install gpgtools
brew cask install tunnelblick
brew cask install zoomus
brew cask install figma
brew cask install transmission
brew cask install fanny

brew cask install spotify

brew tap caskroom/fonts 
brew cask install font-fira-code
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# Not on cask but I want regardless.

# https://www.focustodo.cn/