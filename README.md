
dotfiles
===================

## Installation (Mac OS X)

Clone this repo (or your own fork!) to your home directory.
```
$ cd ~
$ git clone https://github.com/onursatici/dotfiles
```
symlink files in the dotfiles folder
```
$ sh dotfiles/install/install.sh
```
install Xcode command line tools, MacVim, reattach-to-user-namespace and tmux
```
$ xcode-select --install
$ brew install macvim --override-system-vim
$ brew install reattach-to-user-namespace
$ brew install tmux
```

clone vundle to `~/.vim/bundle/Vundle.vim`
install vim plugins via `:PluginInstall` on vim

get iterm2 and choose a base 16 color scheme for it

patch fonts by using the ryanoasis/nerd-fonts repo, svn can be used to download
single fonts by using:
```
$ svn export https://github.com/ryanoasis/nerd-fonts/trunk/path/to/font.ttf
```

### Recommended

**Prezto**  
Use Prezto instead of Bash. info & installation instructions here: https://github.com/sorin-ionescu/prezto
