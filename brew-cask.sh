#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`


# Install native apps

brew install caskroom/cask/brew-cask
# brew tap caskroom/versions
# Get package names from https://formulae.brew.sh/cask/jetbrains-toolbox#default

# daily
brew install --cask spectacle
brew install --cask dropbox
brew install --cask google-drive-file-stream # for team
brew install --cask google-backup-and-sync
brew install --cask 1password
brew install --cask cleanmymac
brew install --cask slack
brew install --cask alfred
brew install --cask boostnote
brew install --cask notion
brew install --cask kap
brew install --cask google-chrome
brew install --cask firefox
brew install --cask brave-browser

# dev
brew install --cask iterm2
brew install --cask docker
brew install --cask hyper
brew install --cask sublime-text
brew install --cask visual-studio-code
brew install --cask jetbrains-toolbox
brew install --cask pycharm
brew install --cask macvim
brew install --cask imagealpha
brew install --cask imageoptim
brew install --cask pixelsnap

# less often
brew install --cask disk-inventory-x
brew install --cask screenflow
brew install --cask vlc
brew install --cask gpgtools
brew install --cask tunnelblick
brew install --cask zoomus
brew install --cask figma
brew install --cask transmission
brew install --cask fanny
brew install --cask lunar
brew install --cask spotify
brew install --cask insomnia

brew install --cask lulu
brew install --cask discord
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-sauce-code-pro-nerd-font

# Not on cask but I want regardless.
brew cask install inkscape

# https://www.focustodo.cn/
