# dotfiles

This is the configuration of my Xubuntu workstation.

## Instructions

Clone the repo:

```bash
git clone --recurse-submodules https://github.com/adder46/dotfiles
cd dotfiles/deps
```

Install clipnotify:

```bash
make -C clipnotify
sudo cp clipnotify/clipnotify /usr/local/bin
```

Install clipmenu:

```bash
make -C clipmenu
sudo make -C clipmenu install
```

Install passmenu:

```bash
sudo cp passmenu/passmenu /usr/local/bin
```

Install nord-xfce-terminal:

```bash
nord-xfce-terminal/install.sh
```

Install nord-dircolors:

```bash
cp nord-dircolors/src/dir_colors ~
```

Install xmonad and its dependencies:

```bash
cd ..
sudo apt install ghc xmonad xmobar dmenu playerctl
cp -R .config/* ~/.config
cp -R .xmonad ~
ghc --make ~/.xmonad/xmonadctl.hs
sudo cp ~/.xmonad/xmonadctl /usr/bin/xmonadctl
```

Install `Source Code Pro` font:

https://askubuntu.com/questions/193072/how-to-use-the-adobe-source-code-pro-font

Set default WM:

https://askubuntu.com/questions/143376/how-to-change-the-xfce4-default-window-manager
