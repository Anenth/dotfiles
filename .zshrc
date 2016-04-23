# export ZSH=/Users/Anenth/.oh-my-zsh
# ZSH_THEME="kolo"

#ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"

# User configuration

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

# source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# export PYTHONPATH=/usr/local/lib/python2.7/site-packages
# export LANG="en_US.UTF-8"
# export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin/"
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin/:/usr/local/lib/node_modules/
#
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


# added by travis gem
# [ -f /Users/Anenth/.travi/travis.sh ] && source /Users/Anenth/.travis/travis.sh



# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# history
SAVEHIST=100000

# vim bindings
bindkey -v


fpath=( "$HOME/.zfunctions" $fpath )


# antigen time!
source ~/code/antigen/antigen.zsh


######################################################################
### install some antigen bundles

local b="antigen-bundle"

antigen theme kolo

# Don't load the oh-my-zsh's library. Takes too long. No need.
	# antigen use oh-my-zsh

# Guess what to install when running an unknown command.
$b command-not-found

# Helper for extracting different types of archives.
$b extract

# atom editor
$b atom

# homebrew  - autocomplete on `brew install`
$b brew
$b brew-cask

# Tracks your most used directories, based on 'frecency'.
$b robbyrussell/oh-my-zsh plugins/z

# nicoulaj's moar completion files for zsh -- not sure why disabled.
# $b zsh-users/zsh-completions src

# Syntax highlighting on the readline
$b zsh-users/zsh-syntax-highlighting

# history search
$b zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

# suggestions
$b tarruda/zsh-autosuggestions

# colors for all files!
$b trapd00r/zsh-syntax-highlighting-filetypes

# dont set a theme, because pure does it all
$b mafredri/zsh-async
# $b sindresorhus/pure
# $b theme kolo

$b git
$b npm
$b git-extras
$b rand-quote
$b node

# Tell antigen that you're done.
#antigen apply

###
#################################################################################################



# bind UP and DOWN arrow keys for history search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down


export PURE_GIT_UNTRACKED_DIRTY=0

# Automatically list directory contents on `cd`.
auto-ls () {
	emulate -L zsh;
	# explicit sexy ls'ing as aliases arent honored in here.
	hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}
chpwd_functions=( auto-ls $chpwd_functions )


# Enable autosuggestions automatically
#zle-line-init() {
#    zle autosuggest-start
#}

#zle -N zle-line-init


# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history


zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# uncomment to finish profiling
# zprof



# Load default dotfiles
source ~/.bash_profile
source '/usr/local/bin/virtualenvwrapper.sh'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
