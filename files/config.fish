# Fish config of KasRoudra
# ~/.config/fish/config.fish
# Packages required => git, figlet, starship, eza, lolcat, gcc/clang, wget, fortune, cowsay, colorscript, yt-dlp
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_username Fish

set command_array "figlet '$fish_username' | lolcat" \
                  "fortune | cowsay | lolcat" \
                  "cowsay -f eyes '$fish_username' | lolcat" \
                  "cls" \
                  "colorscript random"

function is_installed --argument com
    if test -x (command -v $com)
        return 0
    else
        return 1
    end
end


function random_commands
    set length (count $command_array)
    set -l rand_index (random 1 $length)
    eval "$command_array[$rand_index]"
end

if command -v termux-am > /dev/null 2>&1
    alias whoami="echo $fish_username"
    alias hostname="echo Termux"
end

if ! command -v hostname > /dev/null 2>&1
    if command -v hostnamectl > /dev/null 2>&1
        alias hostname="hostnamectl hostname"
    else
        alias hostname="uname -n"
    end
end


function fish_greeting
    figlet "$fish_username" | lolcat
    echo -e "Welcome Back!\n" | lolcat
    # random_commands
end


# Functions needed for !! and !$
function __history_previous_command
    switch (commandline -t)
    case "!"
        commandline -t $history[1]; commandline -f repaint
    case "*"
        commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
    case "!"
        commandline -t ""
        commandline -f history-token-search-backward
    case "*"
        commandline -i '$'
    end
end
# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

### SPARK ###

set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"

function spark -d "sparkline generator"
    if isatty
        switch "$argv"
            case {,-}-v{ersion,}
                echo "spark version $spark_version"
            case {,-}-h{elp,}
                echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
                echo "examples:"
                echo "       spark 1 2 3 4"
                echo "       seq 100 | sort -R | spark"
                echo "       awk \\\$0=length spark.fish | spark"
            case \*
                echo $argv | spark $argv
        end
        return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
        BEGIN {
            min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
            max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        }
        {
            for (i = j = 1; i <= NF; i++) {
                if ($i ~ /^--/) continue
                if ($i !~ /^-?[0-9]/) data[count + j++] = ""
                else {
                    v = data[count + j++] = int($i)
                    if (max == "" && min == "") max = min = v
                    if (max < v) max = v
                    if (min > v ) min = v
                }
            }
            count += j - 1
        }
        END {
            n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
            scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
            for (i = 1; i <= count; i++)
                out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
            print out
        }
    '
end
### END OF SPARK ###


### FUNCTIONS ###
# Spark functions
function letters
    cat $argv | awk -vFS='' '{for(i=1;i<=NF;i++){ if($i~/[a-zA-Z]/) { w[tolower($i)]++} } }END{for(i in w) print i,w[i]}' | sort | cut -c 3- | spark | lolcat
    printf  '%s\n' 'abcdefghijklmnopqrstuvwxyz'  ' ' | lolcat
end

function cls 
    # echo -en "\x1b[2J\x1b[1;1H"
    # echo "\n\n"
    seq 1 (tput cols) | sort -R | spark | lolcat
    # echo "\n\n"
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
    set from (echo $argv[1] | trim-right /)
    set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

function ytmp4 --argument url
    yt-dlp -c --format (yt-dlp --list-formats $url | tac | grep mp4a | head -n1 | awk '{print $1}') $url
end

function crun --argument filename
    set temp (mktemp)
    switch "$filename"
        case "*.cpp"
            g++ $filename -o $temp
        case "*.c"
            gcc $filename -o $temp
        case "*"
            echo "$filename is not a c file!"
    end
    if test -s $temp
        $temp
    end
end

#function crun --argument filename
#    set temp (mktemp)
#    set ext (echo "$filename" | rev | cut -d "." -f1 | rev)
#    if test "$ext" = "cpp"
#        g++ $filename -o $temp
#    else if test "$ext" = "c"
#        gcc $filename -o $temp
#    else
#        echo "$filename is not a c file!"
#    end
#
#    set content (cat $temp)
#    if ! test -z "$content"
#        $temp
#    end
#end
#

function sendto --argument num
    while read -l input
      echo "$input" | ncat 192.168.0.$num 4444
    end
end

function cheat --argument cmd
    curl https://cheat.sh/$cmd
end

### END OF FUNCTIONS ###


### ALIASES ###
alias clear='bash -c "clear"; fish_greeting'
alias clr='clear'
alias ytmp3="yt-dlp --extract-audio --audio-format mp3 --audio-quality 0"
alias dlf="wget -xnH"
alias dls="wget -mpEk"
alias xcp="xclip -selection clipboard"
alias wl="wc -l"
# alias clear='bash -c "clear"; random_commands'


# navigation
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'


# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | grep -E "^\."'


# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'

# confirm before overwriting something
#alias cp="cp -i"
#alias mv='mv -i'
#alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias du='du -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB


# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'


# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'


### SETTING THE STARSHIP PROMPT ###
starship init fish | source

