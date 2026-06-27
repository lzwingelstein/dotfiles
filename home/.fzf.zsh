# Setup fzf
# ---------
if [[ ! "$PATH" == */home/lz581f9l/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/lz581f9l/.fzf/bin"
fi

source <(fzf --zsh)
