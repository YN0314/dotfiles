# 補完
autoload -U compinit
compinit

# vcs_info バージョン管理情報取得
autoload -Uz vcs_info
setopt prompt_subst

# vcs_info customize
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' unstagedstr "-"
zstyle ':vcs_info:*' formats '%s][%b %c%u%m'
zstyle ':vcs_info:*' actionformats '%s][%b %c%u%m (caution:%a)'

precmd () {
  psvar=()
  LANG=ja_JP.UTF-8 vcs_info
  [[ -n ${vcs_info_msg_0_} ]] && psvar[1]="[${vcs_info_msg_0_}]:"
}

# プロンプト
PROMPT='%F{cyan}%1v%f%~
%F{yellow}[%n@%m]%f %# '
PROMPT2='%_%% '
SPROMPT='%r is correct? [n,y,a,e]: '
[[ -n '${REMOTEHOST}${SSH_CONNECTION}' ]] && PROMT='%F{magenda}${HOST%%.*}%f ${PROMPT}'

# Locate
export LANG=ja_JP.UTF-8

# pathのみで移動
setopt auto_cd
# -(タブ)で戻るディレクトリを選択
setopt auto_pushd
#setopt correct
# 補完候補を詰めて表示
setopt list_packed
# =の後のpathを補完する
setopt magic_equal_subst
# ビープ音を鳴らさない
setopt nolistbeep

# Vimキーバインド
bindkey -v

# ヒストリ
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 重複したヒストリを記録しない
setopt hist_ignore_all_dups
# プロセス間でヒストリを共有
setopt share_history
# 先頭にスペースを入れたコマンドは記録しない
setopt hist_ignore_space
# 不要なスペースを削除して記録
setopt hist_reduce_blanks
# historyコマンドを記録しない
setopt hist_no_store

# ヒストリーサーチ
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

export GREP_OPTIONS='--binary-files=without-match --color=auto'
export PAGER=less
export EDITOR=vim

# Aliases
alias v='vim' g='git'

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G"
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac

if which bundler > /dev/null 2>&1; then
  alias be='bundle exec'
  alias bi='bundle install --path .bundle'
fi

if which java > /dev/null 2>&1; then
  alias javac='javac -J-Dfile.encoding=UTF-8'
  alias java='java -Dfile.encoding=UTF-8'
fi

# windowにホスト名を表示
case "${TERM}" in
kterm*|xterm)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST}\007"
  }
  ;;
esac

if [ -d $HOME/.zsh ]; then
  for ext in $HOME/.zsh/*.zsh; do
    source $ext
  done
fi

# Localenv
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

alias tmux="TERM=screen-256color-bce tmux"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -rpi"
