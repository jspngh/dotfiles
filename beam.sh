#!/bin/bash

DOTFILES=$(dirname "$(readlink -f "$0")")
EMACS=${EMACS:-"doom"}

# Beam me up, Scotty
ln -s $(DOTFILES)/.Xresources ~/.Xresources
ln -s $(DOTFILES)/vim/.vimrc ~/.vimrc
ln -s $(DOTFILES)/.gtkrc-2.0 ~/.gtkrc-2.0.mine

# Openbox
mkdir -p ~/.config/openbox
ln -s $(DOTFILES)/openbox/autostart ~/.config/openbox/
ln -s $(DOTFILES)/openbox/environment ~/.config/openbox/
ln -s $(DOTFILES)/openbox/menu.xml ~/.config/openbox/
ln -s $(DOTFILES)/openbox/rc.xml ~/.config/openbox/
# cp -R openbox/themes/* ~/.themes/

mkdir -p ~/.config/dzen/{scripts,icons}
ln -s $(DOTFILES)/dzen/scripts ~/.config/dzen/scripts
ln -s $(DOTFILES)/dzen/icons ~/.config/dzen/icons

mkdir -p ~/.config/fbpanel
ln -s $(DOTFILES)/fbpanel/default ~/.config/fbpanel/default

# tmux
ln -s $(DOTFILES)/tmux/tmux.conf ~/.tmux.conf

# emacs
if [ $EMACS == "doom" ]; then
  mkdir -p ~/.doom.d
  ln -s $(DOTFILES)/emacs/doom/config.el ~/.doom.d/config.el
  ln -s $(DOTFILES)/emacs/doom/init.el ~/.doom.d/init.el
  ln -s $(DOTFILES)/emacs/doom/packages.el ~/.doom.d/packages.el
elif [ $EMACS == "spacemacs" ]; then
  ln -s $(DOTFILES)/emacs/spacemacs/.spacemacs ~/.spacemacs
else
  ln -s $(DOTFILES)/emacs/.emacs ~/.emacs
fi
