function peco_select_history() {
  local tac
  (which gtac &> /dev/null && tac="gtac") || \
    (which tac &> /dev/null && tac="tac") || \
    tac="tail -r"
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle -R -c
}
zle -N peco_select_history
bindkey '^r' peco_select_history

function peco_select_issue() {
  issue=$(github-issues | peco | awk '{print $2}')
  if [ -n "$issue" ]; then
    open $issue
  fi
}
alias i="peco_select_issue"
