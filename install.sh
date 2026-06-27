#!/usr/bin/env sh
# Installe les dotfiles : génère ~/.zshenv puis stow le dossier config/ vers ~/.config
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ~/.zshenv : seul fichier hors ~/.config, pointe ZDOTDIR vers la config zsh stowée
printf 'export ZDOTDIR="$HOME/.config/zsh"\n' > "$HOME/.zshenv"
echo "✓ ~/.zshenv généré (ZDOTDIR=~/.config/zsh)"

# Symlinks de toutes les configs vers ~/.config
stow --dir="$DOTFILES_DIR" --target="$HOME/.config" --restow config
echo "✓ config/ stowé vers ~/.config"
