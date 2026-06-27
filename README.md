# dotfiles

Configs partagées entre deux machines via GNU Stow.

| Machine | OS | Spécificités |
|---|---|---|
| PC perso | macOS | source `.zshrc.private` |
| PC boulot | Debian | source `.zshrc.work`, scripts boulot dans `.zsh/` |

## Structure

```
~/.dotfiles/
├── home/        # fichiers à la racine ~ (stow -t ~ home)
│   ├── .zshenv                      # ZDOTDIR=~/.config/zsh
│   ├── .tmux.conf
│   ├── .tmux-cheatsheet.sh
│   └── .config/
│       ├── starship.toml
│       └── opencode/opencode.jsonc
└── config/      # tout ~/.config/ (stow -t ~/.config config)
    ├── zsh/     # .zshrc, .zshrc.{private,work}, .fzf.zsh, .zsh/
    ├── git/     # config (gitconfig XDG), ignore
    ├── nvim/
    ├── zed/
    ├── lazygit/ lazydocker/
    ├── alacritty/ helix/ yazi/
    ├── k9s/ fish/ htop/
    └── ...      # dotadd <tool> pour ajouter un outil
```

## Installation sur une nouvelle machine

```bash
git clone <repo> ~/.dotfiles
cd ~/.dotfiles

stow -t ~ home
stow -t ~/.config config

# Sur le boulot uniquement : rien de plus, les scripts boulot
# sont dans config/zsh/.zsh/ et chargés automatiquement
```

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
| `home/` | `.zshenv`, tmux, starship, opencode |
| `config/zsh/` | zshrc, fzf, scripts `.zsh/` |
| `config/git/` | gitconfig (XDG), gitignore global |
| `config/nvim/` | LazyVim |
| `config/zed/` | settings, keymap, tasks |
| `config/lazygit/` `config/lazydocker/` | TUI git/docker |
| `config/alacritty/` | terminal |
| `config/helix/` | éditeur |
| `config/yazi/` | file manager |
| `config/k9s/` | kubernetes TUI |
| `config/fish/` `config/htop/` | shell, monitoring |

## Non versionnés

`.ssh/` `.gnupg/` `.kube/` — sensibles  
`.oh-my-zsh/` `.nvm/` `.gvm/` — outils installés  
`config/fish/fish_variables` — généré par fish (gitignored)
