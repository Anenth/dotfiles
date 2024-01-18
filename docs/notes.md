## Prompt
- We are using starship for prompt on top of fish shell


## Load nodejs on new termial 
https://github.com/FabioAntunes/fish-nvm

> fisher install FabioAntunes/fish-nvm edc/bass

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
1. Brew install pyenv, 
2. fisher install daenney/pyenv 
3. pyenv install 3.10.1 & pyenv local 3.10.1 to change the version and use
