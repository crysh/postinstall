#!/bin/bash

#Prerequisites
sudo apt install apt-transport-https wget gdebi-core curl -y

# MakeMKV
sudo add-apt-repository ppa:heyarje/makemkv-beta -y

# Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee -a /etc/apt/sources.list.d/vscode.list

# Powershell
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Add Paper icon theme PPA
sudo add-apt-repository ppa:snwh/ppa -y

# Typora
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./' -y

# ULauncher
sudo add-apt-repository ppa:agornostal/ulauncher -y
sudo apt update

# Mailspring
wget -O ~/Downloads/mailspring.deb "https://updates.getmailspring.com/download?platform=linuxDeb"
yes | sudo gdebi ~/Downloads/mailspring.deb

# Java and JavaWS
sudo apt install default-jre icedtea-netx -y

# Teamviewer
wget -O ~/Downloads/teamviewer.deb "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
sudo apt install ~/Downloads/teamviewer.deb -y

# Utilities
sudo apt install exa htop ssh git zsh bleachbit openconnect screenfetch nautilus-dropbox \
ubuntu-restricted-extras virtualbox virtualbox-guest-additions-iso samba docker.io \
catfish filezilla liferea clementine terminator gufw conky xfonts-terminus openshot \
p7zip-full gnome-tweak-tool chromium-browser flashplugin-installer ulauncher pulseaudio-equalizer \
dconf-editor powershell tmux cifs-utils libreoffice network-manager-openconnect-gnome \
autokey-gtk zsh -y

# Text Editors
sudo apt install sublime-text typora code -y

# Appearance-related
sudo apt install gnome-shell-extensions chrome-gnome-shell paper-icon-theme numix-gtk-theme numix-icon-theme -y

# Entertainment
sudo apt install spotify-client vlc handbrake makemkv-bin -y

# Purge unnecessary applications
sudo apt purge gnome-sudoku gnome-mahjongg gnome-mines gnome-todo gnome-todo-common aisleriot totem vim-common vim-tiny -y

# Configure equalizer and persist on boot
pactl load-module module-equalizer-sink
pactl load-module module-dbus-protocol
# run qpaeq for GUI
echo "load-module module-equalizer-sink" | sudo tee -a /etc/pulse/default.pa
echo "load-module module-dbus-protocol" | sudo tee -a /etc/pulse/default.pa

# Create folders for icons, themes, and fonts
mkdir ~/.themes ~/.icons ~/.fonts

# Install fonts
cd ~/Downloads
wget https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.ttf
wget https://github.com/IBM/plex/releases/download/v1.1.6/TrueType.zip
unzip TrueType.zip
mv TrueType/IBM-Plex-Mono ~/.fonts
mv SourceCodeVariable-Roman.ttf ~/.fonts
fc-cache -f -v

# Fusuma (multi-touch gestures)
#sudo gpasswd -a $USER input
#sudo apt install ruby libinput-tools xdotool -y
#sudo gem install fusuma
#cp ~/Dropbox/Backup/fusuma/config.yml ~/.config/fusuma/config.yml -y
#cp ~/Dropbox/Backup/fusuma/fusuma.desktop ~/.config/autostart/fusuma.desktop

# Settings
echo "alias ll='ls -alFh'" >> ~/.bash_profile

# Clean up
sudo apt autoremove -y

# Change appearance settings
gsettings set org.gnome.desktop.interface clock-show-date "true"
gsettings set org.gnome.desktop.interface clock-format 12h
gsettings set org.gnome.desktop.interface document-font-name 'Sans 9'
gsettings set org.gnome.desktop.interface font-name 'Sans 9'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Variable Medium 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Bold 10'
gsettings set org.gnome.desktop.background primary-color '#0B1E28'
gsettings set org.gnome.desktop.background secondary-color '#0B1E28'
gsettings set org.gnome.desktop.screensaver picture-uri ''
gsettings set org.gnome.desktop.screensaver primary-color '#0B1E28'
gsettings set org.gnome.desktop.screensaver secondary-color '#0B1E28'
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.login-screen logo ''
gsettings set org.gnome.desktop.background picture-uri ''
gsettings set org.gnome.desktop.background show-desktop-icons 'false'
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.desktop.interface enable-animations 'false'
gsettings set org.gnome.desktop.interface menus-have-icons 'true'
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll 'false'
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll 'false'
gsettings set org.gnome.desktop.privacy report-technical-problems 'false'
gsettings set org.gnome.desktop.privacy send-software-usage-stats 'false'
gsettings set org.gnome.desktop.wm.preferences audible-bell 'false'
gsettings set org.gnome.nautilus.list-view default-zoom-level 'small'
gsettings set org.gnome.nautilus.list-view use-tree-view 'false'
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.desktop.interface show-battery-percentage "true"
gsettings set org.gnome.shell.extensions.desktop-icons show-home "false"
gsettings set org.gnome.shell.extensions.desktop-icons show-trash "false"

# Change default keybinding to something other than ALT-space for Ulauncher
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "['<Primary><Shift>space']"

# Fix issue with dock on lock screen
sudo rm -rf /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com

# Add favorites to Dock
gsettings set org.gnome.shell favorite-apps "['chromium-browser.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.tweaks.desktop', 'org.remmina.Remmina.desktop', 'spotify.desktop', 'mailspring.desktop', 'code.desktop', 'sublime_text.desktop', 'firefox.desktop']"

# Change color of lock screen
sudo sed -i '1985s/6D2169/0B1E28/' /etc/alternatives/gdm3.css
sudo sed -i '1986s/370026/0B1E28/' /etc/alternatives/gdm3.css
sudo sed -i '2015s/2C001E/0B1E28/' /etc/alternatives/gdm3.css

# Install autokey-gtk
echo "[D-BUS Service]\nName=org.autokey.Service\nExec=/usr/bin/autokey" | sudo tee /usr/share/dbus-1/services/org.autokey.Service

# Gnome Extensions
cd ~/Downloads
wget -O moveclock.zip https://extensions.gnome.org/extension-data/Move_Clockrmy.pobox.com.v21.shell-extension.zip
wget -O alternatetab.zip https://extensions.gnome.org/extension-data/alternate-tab%40gnome-shell-extensions.gcampax.github.com.v39.shell-extension.zip
wget -O dashtodock.zip https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v68.shell-extension.zip
wget -O topiconsplus.zip https://extensions.gnome.org/extension-data/TopIcons%40phocean.net.v22.shell-extension.zip

mkdir -p "$HOME/.local/share/gnome-shell/extensions/Move_Clock@rmy.pobox.com"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/alternate-tab@gnome-shell-extensions.gcampax.github.com"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/TopIcons@phocean.net"

unzip moveclock.zip -d "$HOME/.local/share/gnome-shell/extensions/Move_Clock@rmy.pobox.com"
unzip alternatetab.zip -d "$HOME/.local/share/gnome-shell/extensions/alternate-tab@gnome-shell-extensions.gcampax.github.com"
unzip dashtodock.zip -d "$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"
unzip topiconsplus.zip -d "$HOME/.local/share/gnome-shell/extensions/TopIcons@phocean.net"

# gnome-shell --replace &

gnome-extensions enable Move_Clock@rmy.pobox.com
gnome-extensions enable alternate-tab@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions enable TopIcons@phocean.net

# Change Dash-to-dock settings
gsettings set org.gnome.shell.extensions.dash-to-dock activate-single-window 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock animate-show-apps 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock autohide 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock background-color '#333d52'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity '0.80000000000000004'
gsettings set org.gnome.shell.extensions.dash-to-dock bolt-support 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'previews'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-border-color '#e95420'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-border-width '0'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-color '#e95420'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock customize-alphas 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size '32'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock force-straight-corner 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock hotkeys-overlay 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock hotkeys-show-dock 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-monitors 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock middle-click-action 'launch'
gsettings set org.gnome.shell.extensions.dash-to-dock minimize-shift 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock preferred-monitor '0'
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DEFAULT'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock show-running 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items 'false'

# Terminal
wget -O Gnome-Terminal.txt https://raw.githubusercontent.com/crysh/postinstall/master/Gnome-Terminal.txt
#dconf dump /org/gnome/terminal/legacy/profiles:/ > Gnome-Terminal.txt
dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/legacy/profiles:/ < Gnome-Terminal.txt

# Sudo no password
sudo sed -i 's/%sudo\tALL=(ALL:ALL) ALL/%sudo ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

# To Do
# Package management in Sublime
# Color scheme in Sublime
# Import/export Remmina connections

# Fix audio
# Copy Dropbox/Backup/Linux/default.pa to /etc/pulse/default.pa
# Run 'qpaeq' for GTK-based equalizer

# Terminal Themes
# bash -c  "$(wget -qO- https://git.io/vQgMr)"

# Powershell
# pwsh
# Install-Module -Scope CurrentUser -Name AWSPowerShell.NetCore -Force
# Install-Module -Scope CurrentUser -Name MSOnline -Force
# For 20.04, Powershell is installed with 'snap install powershell --classic'