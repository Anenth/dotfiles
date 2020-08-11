#!/bin/bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade


# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --default-names


# Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash

brew install bash-completion

brew install homebrew/completions/brew-cask-completion

# Install wget with IRI support
brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install vim --with-override-system-vi
brew install neovim
brew install homebrew/dupes/nano
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# z hopping around folders
# brew install z


# run this script when this file changes guy.
brew install entr
# Install other useful binaries
brew install the_silver_searcher
brew install fzf

brew install git
brew tap jesseduffield/lazygit
brew install lazygit
brew install imagemagick --with-webp
brew install nvm
brew install pv
brew install rename
brew install tree
brew install zopfli
brew install ffmpeg --with-libvpx

brew install terminal-notifier

brew install ncdu # find where your diskspace went

brew install youtube-dl
# https://passingcuriosity.com/2013/dnsmasq-dev-osx/
brew install ensmasq
brew install tmux


# Ruby
brew install rbenv

# Remove outdated versions from the cellar
brew cleanup

mkdir ~/.nvm

# fish
brew install fish
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
