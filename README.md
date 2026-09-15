# dotfiles

Terminal-first setup for macOS. Palette: **void** — near-black, grey, one green accent.

| tool    | file                    |
|---------|-------------------------|
| ghostty | `ghostty/config`, theme `ghostty/themes/void` |
| zsh     | `zsh/.zshrc` — custom one-line prompt, fzf, eza, bat, zoxide |
| tmux    | `tmux/tmux.conf` — prefix `ctrl+space`, top status bar |
| nvim    | `nvim/` — LazyVim, tokyonight recolored to void |
| bat     | `bat/config` |
| git     | `git/.gitconfig` — delta pager |

## Install

```sh
git clone <repo> ~/dotfiles
~/dotfiles/install.sh          # symlink only
~/dotfiles/install.sh --brew   # also install packages + font
exec zsh
```

Existing files are moved to `~/.dotfiles-backup-<timestamp>`.

## Not in repo

- `~/.zsh_secrets` — API keys, sourced by `.zshrc` if present
- `~/.ssh/ssh-menu.zsh` — ssh picker, sourced if present
- `~/.gitconfig-local` — work identity, private git hosts; pulled in via `include`
