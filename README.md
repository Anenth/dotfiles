# Anenth's dotfiles

## Setup
#### installing & using

* fork this to your own acct
* clone that repo
* read and run parts of `setup-a-new-machine.sh`
* read and run `symlink-setup.sh`
  * git config needs attention, read the notes.
* use it. yay!

#### shell environment
* `.aliases`
* `.bash_profile`
* `.bash_prompt`
* `.bashrc`
* `.exports`
* `.functions`
* `.extra` - not included, explained below

#### manual run
* `setup-a-new-machine.sh` - random apps i need installed
* `symlink-setup.sh`  - sets up symlinks for all dotfiles and vim config.
* `.osx` - run on a fresh osx setup
* `brew.sh` & `brew-cask.sh` - homebrew initialization


### shell
1. Install fish shell
2. Add the shell to /etc/shells with:
> echo /usr/local/bin/fish | sudo tee -a /etc/shells
> chsh -s /usr/local/bin/fish


fisherman for fish shell plugin manager
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

### Prompt
brew install starship - its on brew.sh


### TODO
#### 1. Install dropbox
#### 2. Install 1password
#### 3. Add SSH to github

  ```
  ssh-keygen -t rsa -b 4096 -C "anenthvishnu@gmail.com"
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  ```
  Paste it here https://github.com/settings/keys

#### Other Apps 
PixelSnap 2 https://gumroad.com/d/22c168f44d6ff77a4ed3b31b8b6709f3

### Other things to do 

1. Disable Search man Page Index in Terminal in `Apple menu | System Preferences | Keyboard | Shortcuts | Services` 
It will mess up with intellij
https://intellij-support.jetbrains.com/hc/en-us/articles/360005137400-Cmd-Shift-A-hotkey-opens-Terminal-with-apropos-search-instead-of-the-Find-Action-dialog