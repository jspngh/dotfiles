#!/bin/bash

# Beam me up, Scotty
ln -s .Xresources ~/.Xresources
ln -s vim/.vimrc ~/.vimrc
ln -s emacs/.emacs ~/.emacs
ln -s .gtkrc-2.0 ~/.gtkrc-2.0.mine

# Openbox
mkdir ~/.config/openbox
mkdir ~/.config/dzen
mkdir ~/.config/dzen/scripts
mkdir ~/.config/dzen/icons
mkdir ~/.config/fbpanel
ln -s fbpanel/default ~/.config/fbpanel/default
ln -s dzen/scripts ~/.config/dzen/scripts
ln -s dzen/icons ~/.config/dzen/icons
ln -s openbox/autostart ~/.config/openbox/
ln -s openbox/environment ~/.config/openbox/
ln -s openbox/menu.xml ~/.config/openbox/
ln -s openbox/rc.xml ~/.config/openbox/
cp -R openbox/themes/* ~/.themes/

# tmux
ln -s tmux/tmux.conf ~/.tmux.conf
