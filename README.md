# dotfiles

Configs partagées entre deux machines via GNU Stow.

| Machine | OS | Packages à stow |
|---|---|---|
| PC perso | macOS | `home` |
| PC boulot | Debian | `home` + `home-work` |

## Structure

```
~/.dotfiles/
├── home/          # fichiers racine ~ + ~/.config/starship.toml
├── home-work/     # fichiers racine ~ spécifiques au boulot
└── config/        # tout ce qui va dans ~/.config/
    ├── nvim/
    ├── zed/
    ├── lazygit/
    ├── lazydocker/
    ├── alacritty/
    ├── helix/
    ├── yazi/
    ├── k9s/
    ├── fish/
    ├── htop/
    └── git/
```

### `home/`
```
.zshrc  .zshrc.private  .zshrc.work
.zsh/          # fonctions shell communes (journal, notes…)
.gitconfig
.tmux.conf  .tmux-cheatsheet.sh
.fzf.zsh  .fzf.bash
.config/starship.toml
.config/opencode/opencode.jsonc
```

### `home-work/`
```
.zsh/    # proxy exaion, helm, appimage, exaion
```

## Installation sur une nouvelle machine

```bash
git clone <repo> ~/.dotfiles
cd ~/.dotfiles

# Sur les deux machines
stow -t ~ home
stow -d ~/.dotfiles/config -t ~/.config nvim zed lazygit lazydocker alacritty helix yazi k9s fish htop git

# Sur le boulot uniquement
stow -t ~ home-work
```

Pour stow un seul outil :
```bash
stow -d ~/.dotfiles/config -t ~/.config nvim
```

Pour unstow :
```bash
stow -D -d ~/.dotfiles/config -t ~/.config nvim
```

## Outils versionnés

| Outil | Config |
|---|---|
| zsh + oh-my-zsh | `.zshrc`, `.zsh/` |
| starship | `config/starship.toml` |
| neovim | `config/nvim/` |
| zed | `config/zed/` |
| lazygit | `config/lazygit/` |
| lazydocker | `config/lazydocker/` |
| alacritty | `config/alacritty/` |
| helix | `config/helix/` |
| yazi | `config/yazi/` |
| k9s | `config/k9s/` |
| fish | `config/fish/` |
| htop | `config/htop/` |
| git | `.gitconfig` + `config/git/ignore` |
| tmux | `.tmux.conf` |
| fzf | `.fzf.zsh` |

## Non versionnés

`.ssh/`, `.gnupg/`, `.kube/` — données sensibles  
`.oh-my-zsh/`, `.nvm/`, `.gvm/` — outils installés, pas des configs  
`config/fish/fish_variables` — généré automatiquement par fish (gitignored)
