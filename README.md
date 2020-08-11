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
Install fish shell

fisherman for fish shell plugin manager
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher



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

#### 