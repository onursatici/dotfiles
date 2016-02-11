
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
install MacVim, reattach-to-user-namespace and tmux
```
$ brew install macvim --override-system-vim
$ brew install reattach-to-user-namespace
$ brew install tmux
```

install vim plugins via :PluginInstall on vim

get iterm2 and choose a base 16 color scheme for it

patch fonts by using the ryanoasis/nerd-fonts repo, svn can be used to download
single fonts by using:
```
$ svn export https://github.com/ryanoasis/nerd-fonts/trunk/path/to/font.ttf
```

### Gitconfig
don't forget to change the name in gitconfig with your username

### Recommended

**Prezto**  
Use Prezto instead of Bash. info & installation instructions here: https://github.com/sorin-ionescu/prezto

---
These are a heavily modified version of Thoughtbot's dotfiles. More detailed instructions are available here: http://github.com/thoughtbot/dotfiles.
