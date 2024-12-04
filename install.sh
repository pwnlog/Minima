#!/usr/bin/bash

# Author: pwnlog
# Description: Minima installer
# OS Tested: Kali Linux 2024.3
# Devices Tested: Virtual Machine

##################################################################################
#********************************************************************************#
##################################################################################
#                               GLOBALS SECTION                                  #
##################################################################################
#********************************************************************************#
##################################################################################

CWD=$(pwd)
USER_GROUP=$(id -gn $USER) 
DISTRO=$(uname -r | grep kali)
RED=$(printf '\e[0;91m')
BLUE=$(printf '\e[0;94m')
EXPAND_BG=$(printf '\e[K')
GREEN=$(printf '\e[0;92m')
WHITE=$(printf '\e[0;97m')
BOLD=$(printf '\e[1m')
UNDERLINE=$(printf '\e[4m')
RESET=$(printf '\e[0m')

##################################################################################
#********************************************************************************#
##################################################################################
#                             PREREQUISITES SECTION                              #
##################################################################################
#********************************************************************************#
##################################################################################

# Ensure the user is not running as root
if [ $(whoami) == 'root' ]; then
    echo -e "[-] Error: Do NOT run this script as root!"
    echo -e "[i] Information: Do NOT use the 'sudo' command to run this script."
    exit
fi

# Sudo Prompt
echo "[+] Elevating to EUID 0 for a short period"
sudo test

# Update the system packages
sudo apt-get update
if [ $? != 0 ]; then
    cat << EOF
[-] Command: $RED 'sudo apt-get update' $RESET has failed
[-] Solutions: 
    - Please verify that you have an internet connection and also verify if there is a firewall in place
    - Verify if the /etc/apt/sources.list file is configured correctly
EOF
    exit
fi

# Swap partition for systems running with LOW memory space
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# WM
sudo apt-get install -y wmctrl aptitude
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt-get install -y wmctrl' $RESET has failed"
    exit
fi

##################################################################################
#********************************************************************************#
##################################################################################
#                            INSTALL SOFTWARE SECTION                            #
##################################################################################
#********************************************************************************#
##################################################################################

# Install core utils
sudo apt-get install -y zsh zstd thunar xclip coreutils flameshot lxappearance papirus-icon-theme 
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt-get install -y zsh zstd thunar xclip coreutils flameshot lxappearance papirus-icon-theme' $RESET has failed"
    exit
fi

# Install bat
wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb -O bat.deb
if [ $? != 0 ]; then
     echo "[-] Failed to download bat debian package"
     exit
fi
sudo dpkg -i bat.deb || sudo apt install -y bat
if [ $? != 0 ]; then
     echo "[-] Failed to install bat"
     exit
fi

# Install lsd
wget https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd_1.0.0_amd64.deb -O lsd.deb
if [ $? != 0 ]; then
     echo "[-] Failed to download lsd package"
fi
sudo dpkg -i lsd.deb || sudo apt install -y lsd
if [ $? != 0 ]; then
    echo "[+] Trying another method to install lsd"
    ar -x lsd.deb
    zstd -d control.tar.zst
    zstd -d data.tar.zst
    xz control.tar
    xz data.tar
    rm lsd.deb
    ar -rc lsd.deb debian-binary control.tar.xz data.tar.xz
    if [ $? != 0 ]; then
        echo "[-] Failed to install lsd"
        exit
    fi
fi

# Install Alacritty
wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.10.0-rc4-1/alacritty_0.10.0-rc4-1_amd64_bullseye.deb
sudo dpkg -i alacritty_0.10.0-rc4-1_amd64_bullseye.deb
sudo apt install -f

# In case ParrotOS fails to install Alacritty with dpkg
which alacritty
if [ $? != 0 ]; then
    sudo apt install -y alacritty
fi

# Install BSPWM
sudo apt-get install -y libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt-get install -y libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev' $RESET has failed"
    exit
fi
sudo rm -rf bspwm sxhkd 2>/dev/null
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
cd bspwm && make && sudo make install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'cd bspwm && make && sudo make install' $RESET has failed"
    exit
fi
cd ../sxhkd && make && sudo make install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'cd ../sxhkd && make && sudo make install' $RESET has failed"
    exit
fi
cd $CWD

# Add BSPWM to xsessions
sudo cp /usr/local/share/xsessions/bspwm.desktop /usr/share/xsessions/bspwm.desktop

# Install Font Manager
sudo apt install -y font-manager
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y font-manager' $RESET has failed"
    exit
fi

# Install Fonts
# Iosevka ~600 MB
# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/Iosevka.zip -O Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip -O Iosevka.zip
if [ $? != 0 ]; then
    echo "[-] Error: Failed to download Iosevka font"
    exit
fi
sudo unzip -o Iosevka.zip -d /usr/share/fonts/
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo unzip -o Iosevka.zip -d /usr/share/fonts/' $RESET has failed"
    exit
fi

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O JetBrainsMono.zip
if [ $? != 0 ]; then
    echo "[-] Error: Failed to download JetBrainsMono font"
    exit
fi
sudo unzip -o JetBrainsMono.zip -d /usr/share/fonts/
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo unzip -o JetBrainsMono.zip -d /usr/share/fonts/' $RESET has failed"
    exit
fi

#wget https://fonts.google.com/download?family=Roboto -O Roboto.zip
#if [ $? != 0 ]; then
#    echo "[-] Error: Failed to download Roboto font"
#    exit
#fi
sudo unzip -o external/fonts/Roboto.zip -d /usr/share/fonts/
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo unzip -o Roboto.zip -d /usr/share/fonts/' $RESET has failed"
    exit
fi

install_path="/usr/share/fonts/material-design-icons"
url_prefix="https://raw.githubusercontent.com/google/material-design-icons/master/font"
fonts="MaterialIcons-Regular.ttf MaterialIconsOutlined-Regular.otf MaterialIconsRound-Regular.otf"
fonts="$fonts MaterialIconsSharp-Regular.otf MaterialIconsTwoTone-Regular.otf"

for font in $fonts
do
    sudo wget \
        --no-verbose \
        --directory-prefix="$install_path" \
        --output-document="$font" \
        "$url_prefix/$font"
done

# Install Picom Dependencies
sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libpcre3-dev libxcb-sync-dev meson
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libpcre3-dev libxcb-sync-dev meson
' $RESET has failed"
    exit
fi

# Install Picom
wget "https://github.com/yshui/picom/archive/refs/tags/v9.1.zip" -O picomv9.1.zip
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'wget \"https://github.com/yshui/picom/archive/refs/tags/v9.1.zip\" -O picomv9.1.zip' $RESET has failed"
    exit
fi
unzip -o picomv9.1.zip 
cd picom-9.1
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'unzip -o picomv9.1.zip' $RESET has failed"
    exit
fi
meson setup --buildtype=release . build
ninja -C build 
sudo ninja -C build install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo ninja -C build install' $RESET has failed"
    exit
fi
cd $CWD

# Install Rofi
sudo apt-get install -y bison flex check libgdk-pixbuf-2.0-dev libstartup-notification0-dev libxkbcommon-dev libglib2.0-dev libxcb-xkb-dev libxkbcommon-x11-dev libxcb-cursor-dev libpango1.0-dev
sudo apt purge -y rofi 2>/dev/null
wget https://github.com/davatorium/rofi/releases/download/1.7.5/rofi-1.7.5.tar.gz -O rofi-1.7.5.tar.gz
if [ -f "rofi-1.7.5.tar.gz" ]; then
    echo "[+] The file rofi-1.7.5.tar.gz was downloaded."
else 
    echo "[-] The file rofi-1.7.5.tar.gz was not downloaded."
    exit
fi
tar -xvf rofi-1.7.5.tar.gz
cd rofi-1.7.5
rm -rf build 2>/dev/null
mkdir build 
cd build 
../configure 
make 
sudo make install 
if [ $? != 0 ]; then
    echo -e "[-] Error: Failed to install rofi!"
    exit
fi
cd $CWD
sudo rm -rf build

# Install Polybar
pip install sphinx || pip3 install sphinx
sudo apt install -y sphinx build-essential git cmake cmake-data pkg-config python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libpulse-dev libiw-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libjsoncpp-dev libmpdclient-dev libnl-genl-3-dev
wget https://github.com/polybar/polybar/releases/download/3.6.3/polybar-3.6.3.tar.gz -O polybar-3.6.3.tar.gz
echo "f25758573567208fc7b6f4d4115a6117a87389cbcc094cf605d079775be95fa5 polybar-3.6.3.tar.gz" | sha256sum -c
if [ $? != 0 ]; then
    echo "[-] Error: Failed to download polybar-3.6.3.tar.gz correctly!"
    echo "[i] Removing the polybar-3.6.3.tar.gz due to invalid checksum"
    rm polybar-3.6.3.tar.gz 
    exit
fi
tar -xvf polybar-3.6.3.tar.gz
cd polybar-3.6.3
rm -rf build 2>/dev/null
mkdir build
cd build
cmake ..
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'cmake ..' $RESET has failed"
    exit
fi
make -j$(nproc)
sudo make install
if [ $? != 0 ]; then
    echo "[i] Trying another method to install polybar"
    sudo apt install -y polybar
    if [ $? != 0 ]; then
        echo "[-] Command: $RED 'sudo apt install -y polybar' $RESET has failed"
    fi
fi
cd $CWD

# Install Feh
sudo apt install -y feh
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y feh' $RESET has failed"
    exit
fi

# Install latest neovim
sudo apt purge -y neovim 2>/dev/null
sudo apt-get -y install ninja-build gettext cmake unzip curl
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i --force-overwrite nvim-linux64.deb
cd $CWD

# Install LSP neovim related stuff
sudo apt install -y python3-venv cargo npm
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y python3-venv cargo npm' $RESET has failed"
    exit
fi

# Install custom nvchad
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
rm -rf ~/.local/share/nvim 2>/dev/null
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
cp config/nvim/lua/core/bootstrap.lua ~/.config/nvim/lua/core/bootstrap.lua
nvim --headless +qa
cp -r config/nvim ~/.config/
cat <<EOF > install_mason.vim
" Disable user interaction during MasonInstallAll
let g:mason_install_no_prompts = 1

" Run MasonInstallAll
MasonInstallAll
EOF

# Change separator style of nvchad
sed -ie 's/default = { left = "", right = " " }/default = { left = "|", right = "|" }/g' /home/$USER/.local/share/nvim/lazy/ui/lua/nvchad/statusline/default.lua

# Install Powerlevel10K
sudo rm -rf ~/powerlevel10k 2>/dev/null
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k 
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k' $RESET has failed"
    exit
fi

# Install xeventbind
sudo rm -rf xeventbind 2>/dev/null
git clone https://github.com/ritave/xeventbind.git
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'git clone https://github.com/ritave/xeventbind.git' $RESET has failed"
    exit
fi 
cd xeventbind
make
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'make' $RESET has failed"
    exit
fi
sudo cp xeventbind /usr/local/bin 
cd $CWD

# Install i3lock-fancy
sudo apt install -y i3lock
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y i3lock' $RESET has failed"
    exit
fi 
sudo rm -rf i3lock-fancy 2>/dev/null     
git clone https://github.com/meskarune/i3lock-fancy.git
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'git clone https://github.com/meskarune/i3lock-fancy.git' has failed"
    exit
fi     
cd i3lock-fancy
sudo make install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo make install' $RESET has failed"
    exit
fi  
cd $CWD

# Install nsxiv
sudo apt install -y libimlib2-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y libimlib2-dev' $RESET has failed"
    echo -e "\n\n\n"
    echo "$BLUE [!] User interaction might be required $RESET"
    echo -e "\n\n\n"
    sudo aptitude install -y libdeflate0 libdeflate-dev libimlib2-dev
fi  
sudo apt-get install -y libexif-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt-get install -y libexif-dev' $RESET has failed"
    exit
fi 
sudo rm -rf nsxiv 2>/dev/null 
git clone https://github.com/nsxiv/nsxiv
cd nsxiv
sudo make install-all
cd $CWD

# Install Pywal
sudo apt install -y imagemagick pipx
pipx install pywal
sudo pipx install pywal
#git clone https://github.com/dylanaraps/pywal
#cd pywal
#pip3 install --user .
sudo cp $HOME/.local/bin/wal /usr/local/bin/wal
sudo chmod 755 /usr/local/bin/wal
export PATH="${PATH}:${HOME}/.local/bin/"
if [ $? != 0 ]; then
    echo -e "[-] Error: Failed to install pywal!"
    exit
fi
cd $CWD

# Install Tmux
sudo apt install -y libevent-dev ncurses-dev build-essential bison pkg-config
sudo apt install -y tmux

# Configure Tmux (gpakosz)
cd $HOME
sudo rm -rf .tmux 2>/dev/null
git clone https://github.com/gpakosz/.tmux.git 
ln -s -f .tmux/.tmux.conf 
cp .tmux/.tmux.conf.local . 
if [ $? != 0 ]; then
    echo -e "[-] Error: Failed to configure $RED tmux $RESET gpakosz!"
    exit
fi
cd $CWD

# Disable Tmux theme
sed -ie 's/tmux_conf_theme=enabled/tmux_conf_theme=disabled/g' $HOME/.tmux.conf.local

# Install fzf
sudo apt install -y fzf
cp home/.fzf.zsh $HOME/.fzf.zsh
sudo cp home/.fzf.zsh /root/.fzf.zsh

##################################################################################
#********************************************************************************#
##################################################################################
#                         CONFIGURATION FILES SECTION                            #
##################################################################################
#********************************************************************************#
##################################################################################

# Install the configuration files
cp -r $CWD/config/* ~/.config/
sudo cp -r $CWD/config/* /root/.config/

# Install home configuration files
cp $CWD/home/.fehbg $CWD/home/.xmodmaprc $CWD/home/.zshrc $CWD/home/.p10k.zsh ~/
sudo cp $CWD/home/.fehbg $CWD/home/.xmodmaprc $CWD/home/.zshrc $CWD/home/.p10k.zsh /root/

# Init xmodmaprc
xmodmap ~/.xmodmaprc

# Zsh Plugins
if [ -d "/usr/share/fzf-zsh-plugin" ]
then
    echo "/usr/share/fzf-zsh-plugin found."
else
    sudo git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git /usr/share/fzf-zsh-plugin
fi

if [ -d "/usr/share/zsh-autosuggestions" ]
then
    echo "/usr/share/zsh-autosuggestions found."
else
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh-autosuggestions
fi

if [ -d "/usr/share/zsh-syntax-highlighting" ]
then
    echo "/usr/share/zsh-syntax-highlighting found."
else
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/zsh-syntax-highlighting
fi

if [ -d "/usr/share/zsh-completions" ]
then
    echo "/usr/share/zsh-completions found."
else
    sudo git clone https://github.com/zsh-users/zsh-completions /usr/share/zsh-completions
fi

# Fix insecure zsh
sudo chown -R root:root /usr/local/share/zsh/site-functions/_bspc &>/dev/null && sudo chmod -R 755 /usr/local/share/zsh/site-functions/_bspc &>/dev/null

# Change default shell
sudo chsh $USER -s $(which zsh) 
sudo chsh root -s $(which zsh) 

# Install the scripts
sudo cp scripts/aesthetics/* /usr/local/bin/
sudo cp scripts/network/* /usr/local/bin/
sudo cp scripts/system/* /usr/local/bin/
sudo cp scripts/themes/colors/* /usr/local/bin/
sudo cp scripts/themes/enablers/* /usr/local/bin/

##################################################################################
#********************************************************************************#
##################################################################################
#                               MODULES SECTION                                  #
##################################################################################
#********************************************************************************#
##################################################################################

# Video dependencies
sudo apt-get install -y ffmpeg pcregrep mplayer mpv
sudo apt-get install xorg-dev build-essential libx11-dev x11proto-xext-dev libxrender-dev libxext-dev -y 
sudo rm -rf xwinwrap 2>/dev/null
git clone https://github.com/mmhobi7/xwinwrap.git 
cd xwinwrap 
make 
sudo make install 
if [ $? != 0 ]; then
    echo -e "[-] Error: Failed to install xwinwrap!"
    exit
fi
make clean 
cd $CWD

##################################################################################
#********************************************************************************#
##################################################################################
#                             PERMISSIONS SECTION                                #
##################################################################################
#********************************************************************************#
##################################################################################

# BSPWM Permissions
chmod +x ~/.config/bspwm/bspwmrc 
chmod +x ~/.config/bspwm/resize 
chmod +x ~/.config/bspwm/sxhkdrc 

# Polybar permissions
chmod -R 755 ~/.config/polybar 

# Feh permissinons
chmod +x ~/.fehbg

# Nsxiv permissions
chmod +x ~/.config/nsxiv/exec/key-handler 

# Aesthetics Scripts
sudo chown $USER:$USER_GROUP /usr/local/bin/wallpaper-changer 
sudo chmod +x /usr/local/bin/wallpaper-changer 

sudo chown $USER:$USER_GROUP /usr/local/bin/wallpaper-scheduler 
sudo chmod +x /usr/local/bin/wallpaper-scheduler 

sudo chown $USER:$USER_GROUP /usr/local/bin/default-wallpaper
sudo chmod +x /usr/local/bin/default-wallpaper

sudo chown $USER:$USER_GROUP /usr/local/bin/default-polybar
sudo chmod +x /usr/local/bin/default-polybar

sudo chown $USER:$USER_GROUP /usr/local/bin/change-corners
sudo chmod +x /usr/local/bin/change-corners

sudo chown $USER:$USER_GROUP /usr/local/bin/pywal
sudo chmod +x /usr/local/bin/pywal

sudo chown $USER:$USER_GROUP /usr/local/bin/shadows
sudo chmod +x /usr/local/bin/shadows

sudo chown $USER:$USER_GROUP /usr/local/bin/video-wallpaper
sudo chmod +x /usr/local/bin/video-wallpaper

sudo chown $USER:$USER_GROUP /usr/local/bin/move-polybar
sudo chmod +x /usr/local/bin/move-polybar

# System Scripts
sudo chown $USER:$USER_GROUP /usr/local/bin/powermenu
sudo chmod +x /usr/local/bin/powermenu

sudo chown $USER:$USER_GROUP /usr/local/bin/install-tools
sudo chmod +x /usr/local/bin/install-tools

sudo chown $USER:$USER_GROUP /usr/local/bin/polybar-wm
sudo chmod +x /usr/local/bin/polybar-wm

# Network Scripts
sudo chown $USER:$USER_GROUP /usr/local/bin/ethernet-status
sudo chmod +x /usr/local/bin/ethernet-status

sudo chown $USER:$USER_GROUP /usr/local/bin/vpn-status
sudo chmod +x /usr/local/bin/vpn-status

sudo chown $USER:$USER_GROUP /usr/local/bin/copy-ethernet
sudo chmod +x /usr/local/bin/copy-ethernet

sudo chown $USER:$USER_GROUP /usr/local/bin/copy-vpn
sudo chmod +x /usr/local/bin/copy-vpn

sudo chown $USER:$USER_GROUP /usr/local/bin/hack-target
sudo chmod +x /usr/local/bin/hack-target

sudo chown $USER:$USER_GROUP /usr/local/bin/copy-target
sudo chmod +x /usr/local/bin/copy-target

# Theme Scripts
sudo chown $USER:$USER_GROUP /usr/local/bin/enable-colorful-theme
sudo chmod +x /usr/local/bin/enable-colorful-theme

sudo chown $USER:$USER_GROUP /usr/local/bin/colorful-theme
sudo chmod +x /usr/local/bin/colorful-theme

sudo chown $USER:$USER_GROUP /usr/local/bin/enable-light-theme
sudo chmod +x /usr/local/bin/enable-light-theme

sudo chown $USER:$USER_GROUP /usr/local/bin/light-theme
sudo chmod +x /usr/local/bin/light-theme

sudo chown $USER:$USER_GROUP /usr/local/bin/enable-dark-theme
sudo chmod +x /usr/local/bin/enable-dark-theme

sudo chown $USER:$USER_GROUP /usr/local/bin/dark-theme
sudo chmod +x /usr/local/bin/dark-theme

echo "" > ~/.config/target

##################################################################################
#********************************************************************************#
##################################################################################
#                              WALLPAPERS SECTION                                #
##################################################################################
#********************************************************************************#
##################################################################################

# Install wallpapers
mkdir -p ~/Pictures/Wallpapers 
cp $CWD/wallpaper/* ~/Pictures/Wallpapers 

# Edit wallpaper for other usernames
sed -ie "s/kali/$USER/g" ~/.fehbg

# Edit thunar
sed -ie "s/kali/$USER/g" ~/.config/gtk-3.0/bookmarks

# Generate wal cache
wal -i "$HOME/Pictures/Wallpapers/pwning.png" -q -n

##################################################################################
#********************************************************************************#
##################################################################################
#                              PYENV SECTION                                     #
##################################################################################
#********************************************************************************#
##################################################################################

sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.zshrc
echo -e "\n\n$BLUE[i] Installing Pyenv 2.7.18, this is gonna take some time :)$RESET"
$HOME/.pyenv/bin/pyenv install 2.7.18
echo -e "\n\n$BLUE[i] Installing Pyenv 3.11, this is gonna take some time :)$RESET"
$HOME/.pyenv/bin/pyenv install 3.11
$HOME/.pyenv/bin/pyenv versions

##################################################################################
#********************************************************************************#
##################################################################################
#                              INSTALLATION COMPLETED                            #
##################################################################################
#********************************************************************************#
##################################################################################

# Remove temporary swap partition
sudo swapoff /swapfile 2>/dev/null
sudo rm -rf /swapfile 2>/dev/null

# Banner with space
cat <<"EOF"

                 .      .       _   _           ___        |          
     )))       .  .:::.        '\\-//`         /_\ `*      |.===.     
    (o o)        :(o o):  .     (o o)         (o o)        {}o o{}    
ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-                         

        Author: pwnlog

EOF

echo "$GREEN [+] Finished installing Minima in your system, reboot the machine and login to BSPWM.$RESET"