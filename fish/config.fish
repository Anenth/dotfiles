set default_user "anenth"
set default_machine "anenth-mac"
set -g fish_greeting 'Do somthing awesome today'

# Enable vi binding on shell [use fish_default_key_bindings to reset]
fish_vi_key_bindings

source ~/.config/fish/path.fish
source ~/.config/fish/aliases.fish

# Git prompt
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showupstream auto
set __fish_git_prompt_color_branch 'white'
set __fish_git_prompt_color_dirtystate 'white' --bold
set __fish_git_prompt_bg_dirtystate 'white' --bold
set __fish_git_prompt_color_dirtystate_behind white --bold


# # Icons
set __fish_git_prompt_color_branch yellow --italics
set __fish_git_prompt_color_dirtystate 'red'
set __fish_git_prompt_color_upstream_behind blue

set __fish_git_prompt_char_cleanstate ' 👍'
set __fish_git_prompt_char_conflictedstate ' 🤷‍♂️ '
set __fish_git_prompt_char_dirtystate ' 💩 '
set __fish_git_prompt_char_invalidstate ' 🤮'
set __fish_git_prompt_char_stagedstate ' 🚥 '
set __fish_git_prompt_char_stashstate ' 📦 '
set __fish_git_prompt_char_stateseparator ''
set __fish_git_prompt_char_untrackedfiles ' 🔍 '
set __fish_git_prompt_char_upstream_ahead ' 👆 '
set __fish_git_prompt_char_upstream_behind ' 👇 '
set __fish_git_prompt_char_upstream_diverged ' 🚧 '
set __fish_git_prompt_char_upstream_equal ' 💯 ' 



### Tide config
# https://github.com/IlanCosman/tide/wiki/General-Variables
# https://github.com/IlanCosman/tide/wiki/Items

set tide_pwd_max_dirs 1

# set tide_left_prompt_items 'pwd' 'git_prompt' 'prompt_char' 'newline'
# set tide_right_prompt_items 'status' 'context' 'jobs' 'virtual_env'

# function fish_mode_prompt --description 'Displays the current vi mode'
# 	# Do nothing if not in vi mode
# 	if test "$fish_key_bindings" = "fish_vi_key_bindings"
# 	    switch $fish_bind_mode
# 	        case default
# 	            set_color --bold red
# 	            echo -n N
# 	        case insert
# 	            set_color --bold green
# 	            echo -n I
# 	        case replace_one
# 	            set_color --bold green
# 	            echo -n R
# 	        case visual
# 	            set_color --bold brblue
# 	            echo -n V
# 	    end
# 	    set_color normal
# 	    echo -n ' '
# 	end
# end

starship init fish | source
