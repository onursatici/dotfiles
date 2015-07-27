
dotfiles
===================

## Installation

Clone this repo (or your own fork!) to your home directory.
```
$ cd ~
$ git clone https://github.com/onursatici/dotfiles
```
symlink files in the dotfiles folder
```
$ sh dotfiles/install/install.sh
```

### Gitconfig
don't forget to change the name in gitconfig with your username

### Recommended

**MacVim**
```
$ brew install macvim --override-system-vim
```

**iterm2**  
Use iterm2 instead of Terminal: http://iterm2.com/

**Prezto**  
Use Prezto instead of Bash. info & installation instructions here: https://github.com/sorin-ionescu/prezto

**Tmux**  
```
$ brew install tmux
$ brew install reattach-to-user-namespace
```

#### Custom Fonts
For making Airline (vim plugin) look nice, need to use a custom font. See here: https://github.com/Lokaltog/powerline-fonts
I use sourcecode pro. Once installed, go into iterm2 and Profiles > Text. Change both fonts.


---
These are a heavily modified version of Thoughtbot's dotfiles. More detailed instructions are available here: http://github.com/thoughtbot/dotfiles.
