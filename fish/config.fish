set default_user "anenth"
set default_machine "anenth-mac"
set -g fish_greeting 'Do somthing awesome today'

# Enable vi binding on shell [use fish_default_key_bindings to reset]
fish_vi_key_bindings

source ~/.config/fish/path.fish
source ~/.config/fish/aliases.fish

set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showupstream auto
set __fish_git_prompt_color_branch 'white'
set __fish_git_prompt_color_dirtystate 'white' --bold
set __fish_git_prompt_bg_dirtystate 'white' --bold
set __fish_git_prompt_color_dirtystate_behind white --bold

# set __fish_git_prompt_color_upstream_ahead ffb90f
# set __fish_git_prompt_color_upstream_behind blue




# set __fish_git_prompt_color_branch magenta --bold
# set __fish_git_prompt_color_dirtystate white
# set __fish_git_prompt_color_invalidstate red
# set __fish_git_prompt_color_merging yellow
# set __fish_git_prompt_color_stagedstate yellow
# set __fish_git_prompt_color_upstream_ahead green
# set __fish_git_prompt_color_upstream_behind red

set tide_pwd_max_dirs 3

# # Icons
set __fish_git_prompt_char_cleanstate '👍'
set __fish_git_prompt_char_conflictedstate '⚠️ '
set __fish_git_prompt_char_dirtystate '💩 '
set __fish_git_prompt_char_invalidstate '🤮 '
set __fish_git_prompt_char_stagedstate '🚥 '
set __fish_git_prompt_char_stashstate '📦 '
set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_untrackedfiles '🔍 '
set __fish_git_prompt_char_upstream_ahead ' 👆 ️'
set __fish_git_prompt_char_upstream_behind '👇 '
set __fish_git_prompt_char_upstream_diverged '🚧 '
set __fish_git_prompt_char_upstream_equal '💯 ' 

set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_dirtystate 'red'
set __fish_git_prompt_color_upstream_behind blue

