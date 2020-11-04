# xfce-xmonad

**Step 1**:

Install everything:

```sh
sudo apt install ghc xmonad xmobar dmenu playerctl
```
Install `Source Code Pro` font:

https://askubuntu.com/questions/193072/how-to-use-the-adobe-source-code-pro-font

**Step 2**:

Clone the repo and cd into it:

```sh
git clone https://github.com/adder46/xfce-xmonad
cd xfce-xmonad
```

Copy `.xmonad/` and `.xmobarrc` to `$HOME`:

```sh
cp -r .xmonad ~
cp .xmobarrc ~
```

**Step 3**:

```
ghc --make ~/.xmonad/xmonadctl.hs
```

**Step 4**:

Set default WM:

https://askubuntu.com/questions/143376/how-to-change-the-xfce4-default-window-manager

Enjoy!
