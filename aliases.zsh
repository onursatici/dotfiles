# Unix
alias ln='ln -v'
alias mkdir='mkdir -p'
alias l='ls'
alias ll='ls -al'
alias lh='ls -Alh'


# git
alias gs='git status -sb'

#custom
alias til="cd ~/Documents/workspace/learning/til"
alias dev="/usr/local/dev-env/bin/dev"

# colourizer
GRC=`which grc`
if [ "$TERM" != dumb ] && [ -n "$GRC" ]
then
    alias colourify="$GRC -es --colour=auto"
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    alias ss='colourify ss'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
    alias head='colourify head'
    alias tail='colourify tail'
    alias dig='colourify dig'
    alias mount='colourify mount'
    alias ps='colourify ps'
    alias mtr='colourify mtr'
    alias df='colourify df'
    alias ls-'colourify ls'
fi

#quicklook alias
alias ql="qlmanage -p 2>/dev/null"

#make ag call tag (https://github.com/aykamko/tag)
alias ag=tag

# ctags
alias tags="ctags -R --exclude=build --exclude=.git --exclude=node_modules --exclude=vendor --exclude=target"

# docker
alias dps='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias drm='docker rm -f $(docker ps -aq) && docker network ls -qf type=custom | xargs docker network rm'
function dsh() {
  [[ $# -ne 1 ]] && echo "usage: dsh 'name-of-running-container' " && return
  ids=($(docker ps --format "{{.ID}}" --filter "name=$1"))
  docker exec -it $ids[1] /bin/bash
}

# mac y u no
function pwdx {
  lsof -a -p $1 -d cwd -n | tail -1 | awk '{print $NF}'
}

# Include custom aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
