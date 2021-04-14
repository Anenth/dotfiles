## Prompt
- We are using starship for prompt on top of fish shell


## Load nodejs on new termial 
https://github.com/FabioAntunes/fish-nvm

Create a new file 
```bash
vim /usr/local/bin/node
```
with
```bash
#! /usr/bin/env fish

__nvm_run "node" $argv
```
and run 
```bash
chmod +x /usr/local/bin/node
```


## Install python
Brew install pyenv, and fisher install daenney/pyenv then pyenv local 3.~ to change the version and use
