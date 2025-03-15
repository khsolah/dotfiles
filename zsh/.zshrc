# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# neovim
alias sudo='nocorrect sudo '
alias v="nvim"
export EDITOR="nvim"

# eza
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
# alias ls="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions"

# zoxide
alias cd="z"
eval "$(zoxide init zsh)"

# swagger
alias sw="swagger-ui-watcher"

# starship
eval "$(starship init zsh)"

# tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmux/layouts/"
eval "$(tmuxifier init -)"


# pnpm
export PNPM_HOME="/Users/wujiazhan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# fzf
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
