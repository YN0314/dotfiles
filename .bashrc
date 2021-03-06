alias javac="javac -J-Dfile.encoding=UTF-8"
alias java="java -Dfile.encoding=UTF-8"

alias rm="rm -i"
alias cp="cp -i"
alias ls="ls -G"

if [ -d $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias be="bundle exec"

VIMRC="~/.vimrc"
