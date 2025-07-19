# thx to https://github.com/mduvall/config/

function subl --description 'Open Sublime Text'
  if test -d "/Applications/Sublime Text.app"
    "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $argv
  else if test -d "/Applications/Sublime Text 2.app"
    "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" $argv
  else if test -x "/opt/sublime_text/sublime_text"
    "/opt/sublime_text/sublime_text" $argv
  else if test -x "/opt/sublime_text_3/sublime_text"
    "/opt/sublime_text_3/sublime_text" $argv
  else
    echo "No Sublime Text installation found"
  end
end


function killf
  if ps -ef | sed 1d | fzf -m | awk '{print $2}' > $TMPDIR/fzf.result
    kill -9 (cat $TMPDIR/fzf.result)
  end
end

function clone --description "clone something, cd into it. install it."
    git clone --depth=1 $argv[1]
    cd (basename $argv[1] | sed 's/.git$//')
    yarn install
end

function notif --description "make a macos notification that the prev command is done running"
  #  osascript -e 'display notification "hello world!" with title "Greeting" sound name "Submarine"'
  osascript \
    -e "on run(argv)" \
    -e "return display notification item 1 of argv with title \"command done\" sound name \"Submarine\"" \
    -e "end" \
    -- "$history[1]"
end

function beep --description "make two beeps"
  echo -e '\a'; sleep 0.1; echo -e '\a';
end

function all_binaries_in_path --description "list all binaries available in \$PATH, even if theres conflicts"
  # based on https://unix.stackexchange.com/a/120790/110766 but tweaked to work on mac. and then made it faster.
  find -L $PATH -maxdepth 1 -perm +111 -type f
  #gfind -L $PATH -maxdepth 1 -executable -type f # shrug. probably can delete this.
end

function stab --description "stabalize a video"
  set -l vid $argv[1]
  ffmpeg -i "$vid" -vf vidstabdetect=stepsize=32:result="$vid.trf" -f null -;
  ffmpeg -i "$vid" -b:v 5700K -vf vidstabtransform=interpol=bicubic:input="$vid.trf" "$vid.mkv";  # :optzoom=2 seems nice in theory but i dont love it. kinda want a combo of 1 and 2. (dont zoom in past the static zoom level, but adaptively zoom out to full when possible)
  ffmpeg -i "$vid" -i "$vid.mkv" -b:v 3000K -filter_complex hstack "$vid.stack.mkv"
  # vid=Dalton1990/Paultakingusaroundthehouseagai ffmpeg -i "$vid.mp4" -i "$vid.mkv" -b:v 3000K -filter_complex hstack $HOME/Movies/"Paultakingusaroundthehouseagai.stack.mkv"
  command rm $vid.trf
end


function md --wraps mkdir -d "Create a directory and cd into it"
  command mkdir -p $argv
  if test $status = 0
    switch $argv[(count $argv)]
      case '-*'
      case '*'
        cd $argv[(count $argv)]
        return
    end
  end
end

# yes I love this gross combo of shell script, escapes, and node.
function gz --d "Get the gzipped size"
  printf "%-20s %12s\n"  "compression method"  "bytes"
  # TODO.. omg theres no need to go backwards. i can do this in 1 pass.
  set origstr (printf "%-20s %'12.0f"  "original"         (cat "$argv[1]" | wc -c))
  echo $origstr
  set -l array "$origstr"

  # -5 is what GH pages uses, dunno about others
  # fwiw --no-name is equivalent to catting into gzip
  set -a array (printf "%-20s %'12.0f"  "gzipped (-5)"     (cat "$argv[1]" | gzip -5 -c | wc -c))
  echo $array[-1]
  # set -a array (printf "%-20s %'12.0f"  "gzipped (--best)" (cat "$argv[1]" | gzip --best -c | wc -c))
  echo $array[-1]


  # brew install brotli to get these as well
  if hash brotli
  # googlenews uses about -5, walmart serves --best
  set -a array (printf "%-20s %'12.0f\n"  "brotli (-q 5)"    (cat "$argv[1]" | brotli -c --quality=5 | wc -c))
  echo $array[-1]
  # set -a array (printf "%-20s %'12.0f\n"  "brotli (--best)"  (cat "$argv[1]" | brotli -c --best | wc -c))
  echo $array[-1]
  end

  # brew install zstd to get these as well
  if hash zstd
  set -a array (printf "%-20s %'12.0f\n"  "zstd (-3)"      (cat "$argv[1]" | zstd -c -3 - | wc -c))
  echo $array[-1]
  set -a array (printf "%-20s %'12.0f\n"  "zstd (--19)"    (cat "$argv[1]" | zstd -c -19 - | wc -c))
  echo $array[-1]
  set -a array (printf "%-20s %'12.0f\n"  "zstd (--22 --ultra)"    (cat "$argv[1]" | zstd -c -22 --ultra - | wc -c))
  echo $array[-1]
  end

  sleep 0.05
  
  for item in $array
    # ANSI escape cursor movement https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x361.html
    printf "\033[1A"  # up 1 row
  end

  set orig (string replace --all "," "" (string match --regex "  [\d,]+" $origstr))
  for item in $array
    printf "$item   "
    set bytesnum (string replace --all "," "" (string match --regex "  [\d,]+" $item))
    echo "wid = $COLUMNS - 40; console.log('█'.repeat($bytesnum * wid / $orig) + '░'.repeat(wid - ($bytesnum * wid / $orig)))" | node
  end
end

function sudo!!
    eval sudo $history[1]
end


# `shellswitch [bash|zsh|fish]`
function shellswitch
	chsh -s (brew --prefix)/bin/$argv
end

function upgradeyarn
  curl -o- -L https://yarnpkg.com/install.sh | bash
end

function fuck -d 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_commandd $history[1]
    thefuck $fucked_up_commandd > $eval_script
    . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_commandd
    end
end

# requires my excellent `npm install -g statikk`
function server -d 'Start a HTTP server in the current dir, optionally specifying the port'
    # arg can either be port number or extra args to statikk
    if test $argv[1]
      if string match -qr '^-?[0-9]+(\.?[0-9]*)?$' -- "$argv[1]"
        echo $argv[1] is a number
        set port $argv[1]
        statikk --open --port "$port"
      else
        echo "not a number"
        statikk --open $argv[1]
      end

    else
        statikk --open
    end
end


function emptytrash -d 'Empty the Trash on all mounted volumes and the main HDD. then clear the useless sleepimage'
    sudo rm -rfv "/Volumes/*/.Trashes"
    grm -rf "~/.Trash/*"
    rm -rfv "/Users/anenth/Library/Application Support/stremio/Cache"
    rm -rfv "/Users/anenth/Library/Application Support/stremio/stremio-cache"
    rm -rfv "~/Library/Application Support/Spotify/PersistentCache/Update/*.tbz"
    rm -rfv ~/Library/Caches/com.spotify.client/Data
    rm -rfv ~/Library/Caches/Firefox/Profiles/98ne80k7.dev-edition-default/cache2
end


# Example: Convert all SVG files in the current folder to PNG files with size 512x512 using the default converter (magick)
# convert_svg_to_png . 512x512
# Example: Convert all SVG files in the "icons" folder to PNG files with size 256x256 using the converter "inkscape"
# convert_svg_to_png icons 256x256 inkscape

function convert_svg_to_png --description "Converts all SVG files in a folder to PNG files with specified size"

  set svg_folder (count $argv) > /dev/null; and set svg_folder $argv[1]; or set svg_folder .
  set size $argv[2]
  set converter $argv[3] inkscape  # Set default converter to inkscape if not provided

  # Install Converter if not already present
  if not command -sq $converter
    echo "Installing $converter..."
    switch $converter
      case "magick"
        brew install imagemagick
      case "inkscape"
        brew install --cask inkscape
      case "*"
        echo "Unsupported converter: $converter"
    end
  end

  # Loop through each SVG file in the folder
  for svg_file in $svg_folder/*.svg
    # Extract the filename without extension
    set filename (basename -s .svg $svg_file)
    set png_filename $svg_folder/$filename.png

    # Get the size from the SVG file if not specified
    if test -z $size
      set size (sed -n 's/.*width="\([^"]*\)".*height="\([^"]*\)".*/\1x\2/p' $svg_file)
    end

    # Convert the SVG to a PNG file with the specified size and remove the stroke
    switch $converter
      case "magick"
        magick convert -background none -resize $size $svg_file $png_filename
      case "inkscape"
        inkscape --export-type=png --export-filename=$png_filename --export-width=(string split 'x' $size)[1] --export-height=(string split 'x' $size)[2] $svg_file
      case "*"
        echo "Unsupported converter: $converter"
    end

    # Print the filename
    echo "Converted $filename.svg to $filename.png using $converter"
  end

  echo "All SVG files in $svg_folder converted using $converter"
end

# Create a function to convert heic file to jpg from the current folder to a new folder called "jpg"
function heic_to_jpg --description "Converts all HEIC files in a folder to JPG files"

  set heic_folder (count $argv) > /dev/null; and set heic_folder $argv[1]; or set heic_folder .
  set jpg_folder $heic_folder/jpg

  # Create the JPG folder if it doesn't exist
  if not test -d $jpg_folder
    mkdir -p $jpg_folder
  end

  # Loop through each HEIC file in the folder
  for heic_file in $heic_folder/*.heic *.HEIC
    # Extract the filename without extension
    set filename (basename -s .heic (basename -s .HEIC $heic_file))
    set jpg_filename $jpg_folder/$filename.jpg

    # Convert the HEIC to a JPG file
    sips -s format jpeg $heic_file --out $jpg_filename

    # Print the filename
    echo "Converted $filename.heic to $filename.jpg"
  end

  echo "All HEIC files in $heic_folder converted to JPG in $jpg_folder"
end

# Create a function to resize specific png to a specific size (512x512), the argument will contain the path to the file using image magick
function resize_image --description "Resize an image to a specific width while maintaining aspect ratio"
    # Default width is 600 if no width is specified
    set width 600
    
    # Check if the last argument is a number
    if test (count $argv) -gt 0
        if string match -qr '^[0-9]+$' -- $argv[-1]
            set width $argv[-1]
            set files $argv[1..-2]
        else
            set files $argv
        end
    end

    for image_file in $files
        # Check if the file exists
        if not test -f $image_file
            echo "File not found: $image_file"
            continue
        end

        # Get the directory and filename components
        set dirname (dirname $image_file)
        set basename (basename $image_file)
        set filename (string replace -r '\.[^.]*$' '' $basename)
        set extension (string match -r '\.[^.]*$' $basename)
        set resized_filename $dirname/$filename-$width$extension

        # Resize the image using magick
        echo "Resizing $image_file to $resized_filename with width $width"
        magick "$image_file" -resize "$width"x "$resized_filename"

        if test -f $resized_filename
            echo "Successfully resized $image_file to $resized_filename"
        else
            echo "Failed to resize the file: $image_file"
        end
    end
end

function resize_to_600 --description "Resize an image to 600px width while maintaining aspect ratio"
    if test (count $argv) -eq 0
        echo "Please provide the path to the image file"
        return 1
    end

    set image_file $argv[1]
    
    # Check if the file exists
    if not test -f $image_file
        echo "File not found: $image_file"
        return 1
    end

    # Get the filename without extension
    set filename (basename -s (path extension $image_file) $image_file)
    set resized_filename (dirname $image_file)/$filename-600px(path extension $image_file)

    # Resize the image to 600px width while maintaining aspect ratio
    convert $image_file -resize 600x $resized_filename

    if test -f $resized_filename
        echo "Successfully resized $image_file to $resized_filename"
    else
        echo "Failed to resize the image"
        return 1
    end
end
