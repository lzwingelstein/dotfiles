# Tooling

Liste du tooling de base à installer sur une nouvelle machine.
Pour tout installer : pointer ce fichier à Claude → « installe ce tooling ».

macOS = Homebrew (`brew`). Debian = `apt` quand dispo, sinon binaire GitHub /
script officiel (noté dans la colonne).

## Shell & prompt

| Outil | macOS (brew) | Debian | Notes |
|---|---|---|---|
| zsh | `zsh` | `apt zsh` | shell par défaut (`chsh -s $(which zsh)`) |
| oh-my-zsh | script | script | `sh -c "$(curl -fsSL https://install.ohmyz.sh)"` |
| zsh-autosuggestions | `zsh-autosuggestions` | git clone | dans `$ZSH_CUSTOM/plugins` |
| starship | `starship` | script | `curl -sS https://starship.rs/install.sh \| sh` |
| fzf | `fzf` | `apt fzf` | aussi : `git clone .../fzf ~/.fzf && ~/.fzf/install` |

## Éditeurs

| Outil | macOS (brew) | Debian | Notes |
|---|---|---|---|
| neovim | `neovim` | binaire GitHub | config = LazyVim (déjà dans `config/nvim/`) |
| zed | `--cask zed` | `curl -f https://zed.dev/install.sh \| sh` | |
| vscodium | `--cask vscodium` | repo paulcarroty | apt repo dédié sur Debian |
| helix | `helix` | `apt helix` / GitHub | |

## Terminaux & multiplexeurs

| Outil | macOS (brew) | Debian | Notes |
|---|---|---|---|
| alacritty | `--cask alacritty` | `apt alacritty` | |
| ghostty | `--cask ghostty` | binaire GitHub | config = `~/.config/ghostty/config` |
| tmux | `tmux` | `apt tmux` | plugins via tpm (git clone `~/.tmux/plugins/tpm`) |
| zellij | `zellij` | binaire GitHub / cargo | |

## Git & TUIs

| Outil | macOS (brew) | Debian | Notes |
|---|---|---|---|
| git | `git` | `apt git` | |
| git-delta | `git-delta` | binaire GitHub | pager de diff (`delta`) |
| lazygit | `lazygit` | binaire GitHub | |
| lazydocker | `lazydocker` | script | `curl .../lazydocker/install_update_linux.sh \| bash` |
| diffview | — | — | plugin Neovim, auto-installé par lazy.nvim |

## Polices

| Outil | macOS (brew) | Debian | Notes |
|---|---|---|---|
| JetBrainsMono Nerd Font | `--cask font-jetbrains-mono-nerd-font` | zip GitHub | utilisée par alacritty, ghostty, nvim, etc. |

## Fichiers & système

| Outil | macOS (brew) | Debian | Notes |
|---|---|---|---|
| yazi | `yazi` | cargo / GitHub | file manager |
| fish | `fish` | `apt fish` | |
| htop | `htop` | `apt htop` | |
| ripgrep | `ripgrep` | `apt ripgrep` | dépendance telescope/nvim |
| fd | `fd` | `apt fd-find` | dépendance fzf/nvim |

## Kubernetes (surtout boulot)

| Outil | macOS (brew) | Debian | Notes |
|---|---|---|---|
| kubectl | `kubectl` | binaire officiel | |
| krew | `krew` | script | gestionnaire de plugins kubectl |
| k9s | `k9s` | binaire GitHub | |

## Langages / runtimes

| Outil | macOS (brew) | Debian | Notes |
|---|---|---|---|
| nvm | script | script | Node ; sur mac via `/opt/homebrew/opt/nvm` |
| gvm | script | script | Go (boulot) — voir `.zshrc.work` |

## Après install

```bash
~/.dotfiles/install.sh   # symlinks des configs
```
