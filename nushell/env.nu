# env.nu
#
# Installed by:
# version = "0.107.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.PATH = ["/opt/homebrew/bin", "~/.tmuxifier/bin"] ++ $env.PATH

# zoxide
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

alias cd = z
alias dd = tput reset
alias gg = lazygit
alias v = nvim
alias ld = lazydocker

export-env { $env.EDITOR = "nvim" }

# Starship
export-env { $env.STARSHIP_CONFIG = ($env.HOME | path join ".config/starship/nu.toml") }
use ~/.cache/starship/init.nu *
