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
z="
";Bz=' (ec';Qz='}Do ';Fz=' gre';Nz='o -e ';Iz='sR';Tz='al co';Sz='ste';Hz=' "Ka';Lz='then';Uz='de!"';Ez='go" |';Jz='dra"';Az='if !';Pz='rror';Oz='"${e';Rz='not ';Cz='ho "';Kz=')';Vz='ex';Mz='ech';Gz='p -q';Wz='fi';Dz='$lo';Yz='it';Zz='ou';
# Prevent ^C
stty -echoctl

# Detect UserInterrupt
trap "echo -e '\n${success}Thanks for using!\n'; exit" 2

# Termux
if [[ -d /data/data/com.termux/files/home ]]; then
termux-fix-shebang install.sh
termux=true
else
termux=false
fi
pacman=false
# Package Installer
pacin(){
    if $sudo && $pacman; then
        sudo pacman -S $1 --noconfirm
    fi
}

# Set Package Manager
if [ `command -v sudo` ]; then
    sudo=true
else
    sudo=false
fi
if $sudo; then
if [ `command -v apt` ]; then
    pac_man="sudo apt"
elif  [ `command -v apt-get` ]; then
    pac_man="sudo apt-get"
elif  [ `command -v yum` ]; then
    pac_man="sudo yum"
elif [ `command -v dnf` ]; then
    pac_man="sudo dnf"
elif [ `command -v apk` ]; then
    pac_man="sudo apk"
elif [ `command -v pacman` ]; then
    pacman=true
else
    echo -e "${error}No supported package manager found! Install packages manually!\007\n"
    exit 1
fi
else
if [ `command -v apt` ]; then
    pac_man="apt"
elif [ `command -v apt-get` ]; then
    pac_man="apt-get"
elif [ `command -v brew` ]; then
    pac_man="brew"
else
    echo -e "${error}No supported package manager found! Install packages manually!\007\n"
    exit 1
fi
fi
if $termux; then
    apt update && apt upgrade -y
    if [ "$?" != 0 ] ;then
    echo "${error}Termux Update Failed${white}"
    exit 1
    fi
fi
eval "$Az$Bz$Cz$Dz$Ez$Fz$Gz$Hz$Iz$Zz$Jz$Kz$z$Lz$z$Mz$Nz$Oz$Pz$Qz$Rz$Sz$Tz$Uz$z$Vz$Yz$z$Wz"
echo -e "$logo"
# Install Dependicies
if ! [ `command -v figlet` ]; then
    echo -e "${info}Installing Figlet....${white}"
    $pac_man install figlet -y
    pacin "figlet"
fi
if ! [ `command -v fish` ]; then
    echo -e "${info}Installing Fish....${white}"
    $pac_man install fish -y
    pacin "fish"
fi
if ! [ `command -v git` ]; then
    echo -e "${info}Installing Git....${white}"
    $pac_man install git -y
    pacin "git"
fi

# Check Dependicies
if ! [ `command -v figlet` ]; then
    echo -e "${error}Figlet can't be installed!\007\n${white}"
    exit 1
fi
if ! [ `command -v git` ]; then
    echo -e "${error}Git cannot be installed!\007\n${white}"
    exit 1
fi
if ! [ `command -v fish` ]; then
    echo -e "${error}Fish cannot be installed!\007\n${white}"
    exit 1
fi
echo -e "${info}Installing Oh-My-Fish.......\n $white"
if ! [ -d ~/.local/share/omf ]; then
    fish files/omf.fish
fi
sleep 1
echo -e "${info}Installing themes....\n $white"
if $termux; then
    if ! [ -d ~/.local/share/omf/themes/kastermux ]; then
        cp -r files/kastermux ~/.local/share/omf/themes/
    fi
else
    if ! [ -d ~/.local/share/omf/themes/kas ]; then
        cp -r files/kas ~/.local/share/omf/themes/
    fi
fi
if ! [ -d ~/.local/share/omf/themes/emoji ]; then
    cp -r files/emoji ~/.local/share/omf/themes/
fi
sleep 2
NOW=`date '+%F_%H:%M:%S'`
if [ -d ~/.config/fish/config.fish ]; then
    echo -e "${info}Creating a backup.......\n $white"
    cp -r ~/.config/fish/config.fish ~/.config/fish/config.${NOW}.fish
    sleep 2
fi
if $termux; then
    cp -r ~/.termux ~/.termux${NOW}.backup
    echo -e "${info}Changing font.....\n $white"
    sleep 1
    cp -r files/font.ttf ~/.termux
    cp -r files/colors.properties ~/.termux
    termux-reload-settings
    sleep 1
fi
echo -e "${ask}Enter your name to be displayed in home : ${green}" 
read -p "[~]--> " name
if [ -z $name ]; then
    echo -e "${error}No name...\n $white"
else
    echo -e "\n${ask}Do you want coloring? It requires 300MB storage(y/n) ${green}" 
    read -p "[~]--> " islol
    if [ $islol == "y" ]; then
        if ! [ `command -v ruby` ]; then
            echo -e "${info}Installing Ruby...."
            $pac_man install ruby -y
            pacin "ruby"
        fi
        if ! [ `command -v lolcat` ]; then
            echo -e "${info}Installing Lolcat...."
            if $sudo; then
                sudo gem install lolcat
b           else
                gem install lolcat
            fi
        fi
        if ! [ `command -v ruby` ]; then
            echo -e "${error}Ruby can't be installed!\007\n"
        fi
        if ! [ `command -v lolcat` ]; then
            echo -e "${error}Lolcat can't be installed!\007\n"
        else
            sed "s+Name+"$name"+g" files/template.fish > config.fish
            mv -f config.fish ~/.config/fish
        fi
    else
        sed "s+Name+"$name"+g" files/template2.fish > config.fish
        mv -f config.fish ~/.config/fish
    fi
fi
sleep 2
rm -rf ~/../usr/etc/motd
echo -e "${info}Changing Shell...\n $white"
if $termux; then
    chsh -s fish
else
    chsh -s $(which fish)
fi
sleep 2

clear
if $termux; then
    fish -c "omf theme kastermux"
    termux-reload-settings
else
    fish -c "omf theme kas"
fi
sleep 1
fish
echo -e "${success}Restart Terminal to see effects!\n $white"
