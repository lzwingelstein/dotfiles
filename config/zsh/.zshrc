# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  #kubectl golang
  #z extract copypath
  zsh-autosuggestions
  #zsh-syntax-highlighting
  #zsh-completions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases

## Editors
alias code="codium"
alias c="code"
export EDITOR="nvim"

# Opening in editor
alias e="${EDITOR}"
alias zc="e ${ZDOTDIR}/.zshrc"
alias gc="git config --global --edit"
alias notes="codium ~/work/notes"
alias console="e ~/work/console"


# Shorter
alias h=~
alias kube="kubectl"
alias kb=kube
alias cc="clear"
alias q="exit"
alias r="source ${ZDOTDIR}/.zshrc"
alias z="zed"
alias t="tmux"

#alias goland="nohup /home/lz581f9l/.local/bin/goland > /dev/null 2>&1 & disown %1"

alias osk_pcy01='openstack --os-cloud=pcy01'
alias osk_noe01='openstack --os-cloud=noe01'
# osk <cloud> : sélectionne le cloud de clouds.yaml pour toutes les commandes openstack de la session.
# osk         : affiche le cloud courant.   unset OS_CLOUD pour revenir en arrière.
osk() {
  if [[ -n "$1" ]]; then
    export OS_CLOUD=$1
  fi
  echo "${OS_CLOUD:-aucun cloud sélectionné}"
}
alias osk_bvu01='openstack --os-cloud=bvu01'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

cd_fzf_inside() {
  local dir
  dir=$( find . -maxdepth 4 -type d 2>/dev/null | fzf ) && cd -- "$dir"
}
alias cdi=cd_fzf_inside

cd_fzf_outside() {
  local dir
  dir=$( find ~ -maxdepth 4 -type d 2>/dev/null | fzf ) && cd -- "$dir"
}
alias cdo=cd_fzf_outside

# cela pourrait estre plus simple avec un fzf dans le dossier ~/work
cd_fzf_git() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local dir
    dir=$( find . -type d | fzf ) && cd -- "$dir"
  fi
}
alias cdw=cd_fzf_git

cd_fzf_git_global() {
  local dir
  dir=$( find ~/work -name ".git" -type d 2>/dev/null | sed 's|/\.git$||' | fzf ) && cd -- "$dir"
}
alias cdg=cd_fzf_git_global

cd_config() {
  local config_dir
  config_dir=$( (ls -d ~/.tmux.conf ${ZDOTDIR}/.zshrc ${ZDOTDIR}/.zsh/ ~/.config/git/config ~/.bashrc ~/.oh-my-zsh/ ~/.config/nvim/ ~/.config/zed/ ~/.config/opencode/ ~/.config/lazygit/ ~/.config/htop/ ~/.config/gtk-3.0/ ~/.config/fish/ 2>/dev/null) | fzf ) && e "$config_dir"
}
alias ec=cd_config

# alias ohmyzsh="mate ~/.oh-my-zsh"



# Charger les configs
for config in ${ZDOTDIR}/.zsh/*.zsh; do
  [[ -f "$config" ]] && source "$config"
done


export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nvim/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  . "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi

[ -f "${ZDOTDIR}/.fzf.zsh" ] && source "${ZDOTDIR}/.fzf.zsh"

# kubectl-krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export KUBECTL_EXTERNAL_DIFF="delta --color-only"
export GITEA_SERVER_URL="git.exaion.in"

eval "$(starship init zsh)"

# jsql : requête SQL DuckDB sur le JSON reçu en entrée, exposé comme la table `t`.
# usage : openstack image list -f json | jsql "SELECT Name, gio(Size) FROM t"
jsql() {
  duckdb -c "CREATE TABLE t AS SELECT * FROM read_json_auto('/dev/stdin'); $1"
}

# Config spécifique à la machine
[[ "$(uname -s)" == "Darwin" ]] && [[ -f ${ZDOTDIR}/.zshrc.private ]] && source ${ZDOTDIR}/.zshrc.private
[[ "$(uname -s)" == "Linux"  ]] && [[ -f ${ZDOTDIR}/.zshrc.work    ]] && source ${ZDOTDIR}/.zshrc.work

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# mise: gestionnaire de versions d'outils (node, go, pnpm…)
eval "$(mise activate zsh)"
