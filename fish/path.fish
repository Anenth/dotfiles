set default_path /usr/local/bin /usr/bin /bin /usr/sbin /sbin /usr/local/MacGPG2/bin 
set homebrew /opt/homebrew/bin opt/homebrew/sbin
set flutter /Users/anenth/Code/flutter

set -gx PATH $homebrew $default_path $flutter
set PATH ~/bin $PATH