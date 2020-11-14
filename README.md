# dotfiles

## Installing XMonad

**Step 1**:

Install the dependencies:

```sh
sudo apt install ghc xmonad xmobar dmenu playerctl
```

Install `Source Code Pro` font:

https://askubuntu.com/questions/193072/how-to-use-the-adobe-source-code-pro-font

**Step 2**:

Clone the repo and cd into it:

```sh
git clone https://github.com/adder46/dotfiles
cd dotfiles
```

Copy `.xmonad/` and `.xmobarrc` to `$HOME`:

```sh
cp -r .xmonad ~
cp .xmobarrc ~
```

**Step 3**:

Compile `xmonadctl.hs` and add it to PATH:

```
ghc --make ~/.xmonad/xmonadctl.hs
sudo ln -s "$(realpath ~/.xmonad/xmonadctl)" /usr/bin/xmonadctl
```

**Step 4**:

Set default WM:

https://askubuntu.com/questions/143376/how-to-change-the-xfce4-default-window-manager

Enjoy!
