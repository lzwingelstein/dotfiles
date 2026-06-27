dotadd() {
  local tool=${1:?Usage: dotadd <tool>}
  local src="$HOME/.config/$tool"
  local repo="$HOME/.dotfiles"

  if [[ ! -e "$src" ]]; then
    echo "Erreur : ~/.config/$tool n'existe pas" && return 1
  fi

  mv "$src" "$repo/config/"
  stow -R -t ~/.config config
  git -C "$repo" add "config/$tool"
  git -C "$repo" commit -m "add $tool"
}

dotrm() {
  local tool=${1:?Usage: dotrm <tool>}
  local repo="$HOME/.dotfiles"

  rm -rf "$repo/config/$tool"
  stow -R -t ~/.config config
  git -C "$repo" rm -r "config/$tool"
  git -C "$repo" commit -m "remove $tool"
}
