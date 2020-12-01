# dotfiles

This is the configuration of my Xubuntu workstation.

## Instructions

Clone the repo:

```bash
git clone --recurse-submodules https://github.com/adder46/dotfiles
```

Then proceed by following the official instructions to install dependencies in the `deps` folder.

Copy everything in the `scripts` folder somewhere in your PATH.

Copy everything in the `.config` folder to `~/.config`:

```bash
cp -R .config/* ~/.config
```

Install xmonad and its dependencies:

```bash
sudo apt install ghc xmonad xmobar dmenu playerctl
cp -R dotfiles/.xmonad ~
ghc --make ~/.xmonad/xmonadctl.hs
sudo cp ~/.xmonad/xmonadctl /usr/bin/xmonadctl
```

Install `Source Code Pro` font:

https://askubuntu.com/questions/193072/how-to-use-the-adobe-source-code-pro-font

Set default WM:

https://askubuntu.com/questions/143376/how-to-change-the-xfce4-default-window-manager
