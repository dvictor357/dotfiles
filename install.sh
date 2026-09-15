#!/usr/bin/env bash
# Symlink dotfiles into place. Existing targets are backed up to ~/.dotfiles-backup-<timestamp>.
set -euo pipefail

DOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BAK="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

link() {
    local src="$DOT/$1" dst="$2"
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        echo "  ok   $dst"
        return
    fi
    if [[ -e "$dst" || -L "$dst" ]]; then
        mkdir -p "$BAK"
        mv "$dst" "$BAK/$(basename "$dst")"
        echo "  bak  $dst -> $BAK/"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "  link $dst -> $src"
}

# copy once, never overwrite — for files the program rewrites at runtime (state)
seed() {
    local src="$DOT/$1" dst="$2"
    if [[ -e "$dst" ]]; then
        echo "  keep $dst"
        return
    fi
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "  seed $dst <- $src"
}

echo "linking..."
link ghostty           "$HOME/.config/ghostty"
link tmux              "$HOME/.config/tmux"
link bat               "$HOME/.config/bat"
link nvim              "$HOME/.config/nvim"
link zsh/.zshrc        "$HOME/.zshrc"
link git/.gitconfig    "$HOME/.gitconfig"
link herdr/config.toml "$HOME/.config/herdr/config.toml"
link herdr/cheatsheet.txt "$HOME/.config/herdr/cheatsheet.txt"
link lazygit/config.yml   "$HOME/Library/Application Support/lazygit/config.yml"  # macOS lazygit ignores ~/.config
link btop/themes          "$HOME/.config/btop/themes"
seed btop/btop.conf       "$HOME/.config/btop/btop.conf"   # btop rewrites this on exit

if [[ "${1:-}" == "--brew" ]]; then
    echo "installing brew packages from Brewfile..."
    brew bundle install --file="$DOT/Brewfile"
fi

echo "done. restart shell: exec zsh"
