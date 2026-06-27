# dotfiles

Configs partagées entre deux machines via GNU Stow.

| Machine | OS | Spécificités |
|---|---|---|
| PC perso | macOS | source `.zshrc.private` |
| PC boulot | Debian | source `.zshrc.work`, scripts boulot dans `.zsh/` |

## Structure

Tout vit dans `~/.config/`. Le seul fichier hors `~/.config/` est `~/.zshenv`,
généré par `install.sh` (il sert juste à pointer `ZDOTDIR` vers `~/.config/zsh`).

```
~/.dotfiles/
├── install.sh   # génère ~/.zshenv + stow config/ vers ~/.config
└── config/      # tout ~/.config/ (un sous-dossier = un outil)
    ├── zsh/     # .zshrc, .zshrc.{private,work}, .fzf.zsh, .zsh/
    ├── git/     # config (gitconfig XDG), ignore
    ├── tmux/    # tmux.conf, tmux-cheatsheet.sh
    ├── nvim/  zed/
    ├── lazygit/  lazydocker/
    ├── alacritty/  helix/  yazi/
    ├── k9s/  fish/  htop/
    ├── starship.toml  opencode/
    └── ...      # dotadd <tool> pour ajouter un outil
```

## Installation sur une nouvelle machine

```bash
git clone <repo> ~/.dotfiles
~/.dotfiles/install.sh
```

Le script est idempotent : relançable à tout moment pour re-stow.
Les scripts spécifiques au boulot sont dans `config/zsh/.zsh/` et chargés
automatiquement (les fonctions définies sont inoffensives sur le mac).

## Stow : charger les configs

**Tout est chargé en une seule commande, pas outil par outil.** `config/` est
un unique package stow : on le traite d'un bloc, et stow crée tous les symlinks
`~/.config/<outil> -> ~/.dotfiles/config/<outil>` d'un coup.

```bash
# Charger TOUTES les configs (c'est ce que fait install.sh)
stow --dir=~/.dotfiles --target=~/.config config
```

> Il n'y a pas de `stow nvim` puis `stow zed` séparés : la commande ci-dessus
> les installe tous ensemble. Pour ajouter un nouvel outil au repo, voir
> [Ajouter / supprimer un outil](#ajouter--supprimer-un-outil) ci-dessus.

Autres opérations sur le même package :

```bash
# Re-charger après avoir ajouté/déplacé un fichier (idempotent)
stow --dir=~/.dotfiles --target=~/.config --restow config

# Tout délier (supprime les symlinks, garde le repo)
stow --dir=~/.dotfiles --target=~/.config --delete config

# Simuler sans rien modifier, pour vérifier avant
stow --dir=~/.dotfiles --target=~/.config --simulate --verbose config
```

`--dir` = où sont les packages, `--target` = où créer les symlinks, `config`
= le package traité.

## Ajouter / supprimer un outil

```bash
# Ajouter : déplace ~/.config/<tool>/ dans le repo et restow
dotadd wezterm

# Supprimer : inverse
dotrm wezterm
```

Ces fonctions sont définies dans `config/zsh/.zsh/dotfiles.zsh`.

## Outils versionnés

| Package | Contenu |
|---|---|
| `config/zsh/` | zshrc, fzf, scripts `.zsh/` |
| `config/git/` | gitconfig (XDG), gitignore global |
| `config/tmux/` | tmux.conf, cheatsheet |
| `config/nvim/` | LazyVim |
| `config/zed/` | settings, keymap, tasks |
| `config/lazygit/` `config/lazydocker/` | TUI git/docker |
| `config/alacritty/` | terminal |
| `config/helix/` | éditeur |
| `config/yazi/` | file manager |
| `config/k9s/` | kubernetes TUI |
| `config/fish/` `config/htop/` | shell, monitoring |
| `config/starship.toml` `config/opencode/` | prompt, agent CLI |

## Non versionnés

`.ssh/` `.gnupg/` `.kube/` — sensibles  
`.oh-my-zsh/` `.nvm/` `.gvm/` — outils installés  
`config/fish/fish_variables` — généré par fish (gitignored)
