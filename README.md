# dotfiles

This is the configuration of my Xubuntu workstation.

## Instructions

Install clipnotify:

```
git clone https://github.com/cdown/clipnotify.git
make -C clipnotify
sudo cp clipnotify/clipnotify /usr/local/bin
```

Install clipmenu:

```
git clone https://github.com/cdown/clipmenu.git
make -C clipmenu
sudo make -C clipmenu install
```

Install passmenu:

```
git clone https://github.com/adder46/passmenu.git
sudo cp passmenu/passmenu /usr/local/bin
```

Install xmonad and its dependencies:

```sh
sudo apt install ghc xmonad xmobar dmenu playerctl
git clone https://github.com/adder46/dotfiles
cp -R dotfiles/.config/* ~/.config
cp -R dotfiles/.xmonad ~
ghc --make ~/.xmonad/xmonadctl.hs
sudo ln -s "$(realpath ~/.xmonad/xmonadctl)" /usr/bin/xmonadctl
```

Install `Source Code Pro` font:

https://askubuntu.com/questions/193072/how-to-use-the-adobe-source-code-pro-font

Set default WM:

https://askubuntu.com/questions/143376/how-to-change-the-xfce4-default-window-manager
