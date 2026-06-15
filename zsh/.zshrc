# --- helpers ---
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

path_add() {
  [[ -d "$1" ]] || return
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

# --- environment ---
path_add "$HOME/.local/bin"
path_add "$HOME/go/bin"

if command -v brew >/dev/null 2>&1; then
  rustup_prefix="$(brew --prefix rustup 2>/dev/null)"
  path_add "$rustup_prefix/bin"
fi

if [[ -r "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  . "$NVM_DIR/nvm.sh"
elif command -v brew >/dev/null 2>&1; then
  nvm_prefix="$(brew --prefix nvm 2>/dev/null)"
  if [[ -s "$nvm_prefix/nvm.sh" ]]; then
    . "$nvm_prefix/nvm.sh"
  fi
fi

export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"
export OBSIDIAN_VAULT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"

# --- prompt ---
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# --- utilities ---
lazygit() {
  if [[ -x "$HOME/.config/lazygit/sync-theme.zsh" ]]; then
    "$HOME/.config/lazygit/sync-theme.zsh"
  fi

  command lazygit "$@"
}

copy_aws_creds_from_clipboard() {
  local clip
  clip="$(pbpaste)"

  if [[ "$clip" != *aws_access_key_id* || "$clip" != *aws_secret_access_key* ]]; then
    echo "Clipboard does not look like AWS credentials; aborting." >&2
    return 1
  fi

  mkdir -p "$HOME/.aws"
  print -r -- "$clip" > "$HOME/.aws/credentials"
  echo "AWS credentials updated."
}

alias awscopy=copy_aws_creds_from_clipboard

notes() {
  if [[ ! -d "$OBSIDIAN_VAULT" ]]; then
    echo "Obsidian vault not found: $OBSIDIAN_VAULT" >&2
    return 1
  fi

  cd "$OBSIDIAN_VAULT" || return
}
