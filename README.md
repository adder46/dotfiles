# dotfiles

## Installing XMonad

**Step 1**:

Install the dependencies:

```sh
sudo apt install ghc xmonad xmobar dmenu playerctl
```

Install clipnotify and clipmenu:

```sh
git clone https://github.com/cdown/clipnotify.git
cd clipnotify
make
sudo make install
cd ..
git clone https://github.com/cdown/clipmenu.git
cd clipmenu
sudo make install
```

To autostart clipmenud, add the following to `~/.config/autostart/clipmenud.desktop`:

```
[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=clipmenud
Comment=clipmenud
Exec=clipmenud
OnlyShowIn=XFCE;
RunHook=0
StartupNotify=false
Terminal=false
Hidden=false
```

Install passmenu:

```
git clone https://github.com/adder46/passmenu.git
cd passmenu
sudo cp passmenu /usr/bin
cd ..
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
