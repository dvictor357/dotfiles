# dotfiles

Terminal-first setup for macOS. Palette: **void** — near-black, grey, one green accent.

| tool    | file                    |
|---------|-------------------------|
| ghostty | `ghostty/config`, theme `ghostty/themes/void` |
| zsh     | `zsh/.zshrc` — custom one-line prompt, fzf, eza, bat, zoxide |
| tmux    | `tmux/tmux.conf` — prefix `ctrl+space`, top status bar |
| herdr   | `herdr/config.toml` + `herdr/cheatsheet.txt` — void theme, bottom status bar, prefix `ctrl+space`, nvim-style pane keys |
| nvim    | `nvim/` — LazyVim, tokyonight recolored to void; no bufferline/noice, flat lualine, bare dashboard |
| lazygit | `lazygit/config.yml` — void theme, delta pager, nerd icons |
| btop    | `btop/themes/void.theme`, `btop/btop.conf` (seeded once, btop owns it after) |
| bat     | `bat/config` |
| git     | `git/.gitconfig` — delta pager; `git/.gitignore_global` |
| brew    | `Brewfile` — curated: terminal core, cli tools, fonts, apps |

## Install

```sh
git clone https://github.com/dvictor357/dotfiles ~/dotfiles
~/dotfiles/install.sh          # symlink only
~/dotfiles/install.sh --brew   # also brew bundle the Brewfile (cli, fonts, apps)
exec zsh
```

Existing files are moved to `~/.dotfiles-backup-<timestamp>`.

## Local overrides

Machine-specific config lives outside the repo. Each file is optional and
picked up automatically if it exists:

| file | purpose |
|------|---------|
| `~/.zshrc.local` | extra env vars, aliases, anything private |
| `~/.gitconfig-local` | per-machine git identity and `includeIf` rules |
