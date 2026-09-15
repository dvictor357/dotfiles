# ============================================================================
# PATH
# ============================================================================
typeset -U path fpath

path=(
    "$HOME/.bun/bin"
    "$HOME/.local/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "$HOME/Library/Application Support/Herd/bin"
    "/opt/homebrew/opt/openjdk@21/bin"
    "/opt/homebrew/opt/mysql-client/bin"
    "$HOME/Library/Android/sdk/platform-tools"
    "$HOME/Library/Android/sdk/emulator"
    "$HOME/Library/Android/sdk/cmdline-tools/latest/bin"
    "$HOME/.pub-cache/bin"
    "$HOME/.daml/bin"
    "$HOME/.antigravity/antigravity/bin"
    "$HOME/.lmstudio/bin"
    "$HOME/.grok/bin"
    "$HOME/.local/share/solana/install/active_release/bin"
    $path
)

# ============================================================================
# Environment
# ============================================================================
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R -i -F -X --mouse"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export BUN_INSTALL="$HOME/.bun"

# Herd PHP
export HERD_PHP_74_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/74/"
export HERD_PHP_84_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/84/"
export HERD_PHP_85_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/85/"

# ============================================================================
# Oh My Zsh  (theme off — custom prompt below)
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE="true"

[[ -d "$HOME/.daml/zsh" ]]            && fpath=("$HOME/.daml/zsh" $fpath)
[[ -d "$HOME/.grok/completions/zsh" ]] && fpath=("$HOME/.grok/completions/zsh" $fpath)

source "$ZSH/oh-my-zsh.sh"

# ============================================================================
# Plugins
# ============================================================================
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# accept suggestion: → or ctrl+e  (ctrl+space reserved for tmux prefix)

# ============================================================================
# History
# ============================================================================
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_SPACE
setopt SHARE_HISTORY EXTENDED_HISTORY INC_APPEND_HISTORY

# ============================================================================
# Completion
# ============================================================================
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{8}-- %d --%f'
setopt AUTO_CD GLOB_DOTS NO_BEEP

# ============================================================================
# Prompt — one line, no noise
#   ~/proj main* ❯          (❯ green ok / red fail / # when root)
#   right side: last command duration if > 2s
# ============================================================================
zmodload zsh/datetime
setopt PROMPT_SUBST
autoload -Uz add-zsh-hook

_git_info() {
    local ref dirty
    ref=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null) \
        || ref=$(git --no-optional-locks rev-parse --short HEAD 2>/dev/null) \
        || return
    [[ -n $(git --no-optional-locks status --porcelain -uno 2>/dev/null | head -1) ]] && dirty='*'
    print -n " %F{8}${ref}%F{2}${dirty}%f"
}

_prompt_preexec() { _cmd_start=$EPOCHREALTIME; }
_prompt_precmd() {
    _cmd_dur=''
    if [[ -n $_cmd_start ]]; then
        local d=$(( EPOCHREALTIME - _cmd_start ))
        (( d > 2 )) && _cmd_dur=$(printf '%.1fs' $d)
        unset _cmd_start
    fi
}
add-zsh-hook preexec _prompt_preexec
add-zsh-hook precmd  _prompt_precmd

[[ -n $SSH_CONNECTION ]] && _host='%F{8}%m ' || _host=''
PROMPT="${_host}"'%F{7}%~%f$(_git_info) %(!.%F{1}#.%(?.%F{2}.%F{1})❯)%f '
RPROMPT='%F{8}${_cmd_dur}%f'

# ============================================================================
# fzf  (ctrl+r history · ctrl+t files · alt+c dirs)
# ============================================================================
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="
  --height 40% --layout reverse --border sharp --info inline
  --prompt '❯ ' --pointer '▸' --marker '·'
  --color=bg:-1,bg+:#161616,gutter:-1,border:#262626
  --color=fg:#c9c9c9,fg+:#ededed,hl:#5fb56a,hl+:#7ccb84
  --color=prompt:#5fb56a,pointer:#5fb56a,marker:#5fb56a,spinner:#5fb56a
  --color=info:#4a4a4a,header:#4a4a4a
  --bind 'ctrl-/:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range :200 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always --icons=auto {}'"
export FZF_CTRL_R_OPTS="--no-preview"
source <(fzf --zsh)

# ============================================================================
# Tools
# ============================================================================
eval "$(zoxide init zsh)"

alias ls='eza --group-directories-first --icons=auto'
alias ll='eza -l --group-directories-first --icons=auto --git --no-user --time-style=relative'
alias la='ll -a'
alias lt='eza --tree --level=2 --icons=auto --git-ignore'
alias cat='bat --paging=never'
alias v='nvim'
alias vim='nvim'
alias lg='lazygit'
alias t='tmux new -A -s main'
alias top='btop'
alias grep='grep --color=auto'

# ============================================================================
# Aliases (project)
# ============================================================================
alias art="php artisan"
alias ff="fastfetch"
alias psql="/Users/Shared/DBngin/postgresql/18.1/bin/psql"
alias ccw="CLAUDE_CONFIG_DIR=~/.claude-work claude"
alias ccp="CLAUDE_CONFIG_DIR=~/.claude claude"
alias tcheat="cat ~/.config/tmux/cheatsheet.txt"
alias hcheat="cat ~/.config/herdr/cheatsheet.txt"
alias herdforge="/Applications/Herd/bin/forge"

# ============================================================================
# Integrations
# ============================================================================
export NVM_DIR="$HOME/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && \
    builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

[ -s "$HOME/.bun/_bun" ]   && source "$HOME/.bun/_bun"
[ -f ~/.zsh_secrets ]      && source ~/.zsh_secrets
[ -f ~/.ssh/ssh-menu.zsh ] && source ~/.ssh/ssh-menu.zsh
[ -f ~/.zshrc.local ]      && source ~/.zshrc.local   # machine-local overrides, not in repo

if output="$(mole completion zsh 2>/dev/null)"; then eval "$output"; fi

# >>> forge initialize >>>
# !! Contents within this block are managed by 'forge zsh setup' !!
# !! Do not edit manually - changes will be overwritten !!

# Add required zsh plugins if not already present
if [[ ! " ${plugins[@]} " =~ " zsh-autosuggestions " ]]; then
    plugins+=(zsh-autosuggestions)
fi
if [[ ! " ${plugins[@]} " =~ " zsh-syntax-highlighting " ]]; then
    plugins+=(zsh-syntax-highlighting)
fi

# Editor for editing prompts (set during setup)
# To change: update FORGE_EDITOR or remove to use $EDITOR
