# --- homebrew ---
# .zprofile already does this for login shells; only repeat it when it hasn't run.
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# --- PATH ---
# Highest priority first. Missing directories are skipped; duplicates are dropped.
typeset -U path
_front=(
  "$HOME/.local/bin"                                  # node, claude, cua-driver, hermes
  "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/rustup/bin"
  "/Applications/Codex.app/Contents/Resources"
  "$HOME/go/bin"
)
path=(${^_front}(N-/) $path)
unset _front

# --- environment ---
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

notes() {
  if [[ ! -d "$OBSIDIAN_VAULT" ]]; then
    echo "Obsidian vault not found: $OBSIDIAN_VAULT" >&2
    return 1
  fi

  cd "$OBSIDIAN_VAULT" || return
}
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/kp/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# --- work ---
# Machine-local work setup; the file is not tracked in this repo.
[[ -r "$HOME/.config/zsh/work.zsh" ]] && source "$HOME/.config/zsh/work.zsh"

# Select an AWS profile, verify it, and offer its known login flow when needed.
awsctx() {
  emulate -L zsh
  local profiles selected_profile candidate found=0 identity auth_rc reply
  local sso_session sso_start_url credential_process needs_login=0
  local -a login_command

  profiles="$(command aws configure list-profiles)" || return
  [[ -n "$profiles" ]] || return 1
  selected_profile="$(printf '%s\n' "$profiles" | command fzf --no-multi --prompt='AWS profile > ')" || return
  for candidate in "${(@f)profiles}"; do
    if [[ "$candidate" == "$selected_profile" ]]; then
      found=1
      break
    fi
  done
  (( found )) || return 1
  export AWS_PROFILE="$selected_profile"
  printf 'AWS profile: %s\n' "$AWS_PROFILE"
  if [[ -n "$AWS_DEFAULT_PROFILE" && "$AWS_DEFAULT_PROFILE" != "$AWS_PROFILE" ]]; then
    printf 'Warning: AWS_DEFAULT_PROFILE is also set and may override plain AWS commands. These checks use explicit --profile; neither variable is cleared.\n' >&2
  fi
  if [[ -n "$AWS_ACCESS_KEY_ID" || -n "$AWS_SECRET_ACCESS_KEY" || -n "$AWS_SESSION_TOKEN" || -n "$AWS_SECURITY_TOKEN" ]]; then
    printf 'Warning: AWS credential environment variables are set and may override plain AWS commands. They are not displayed or cleared.\n' >&2
  fi

  identity="$(command aws sts get-caller-identity --profile "$AWS_PROFILE" --no-cli-pager --query '{Account:Account,Arn:Arn}' --output json 2>&1)"
  auth_rc=$?
  if (( auth_rc == 0 )); then
    printf '%s\n' "$identity"
    return 0
  fi
  printf '%s\n' "$identity" >&2

  # Match explicit credential/session errors, not generic provider login hints.
  case "$identity" in
    *'Token has expired and refresh failed'*|\
    *'Error loading SSO Token:'*'does not exist'*|\
    *'The SSO session associated with this profile has expired or is otherwise invalid'*|\
    *'(ExpiredToken)'*|*'(ExpiredTokenException)'*|\
    *'Unable to locate credentials'*|\
    *'no browser portal session'*|*'no portal session found'*|\
    *'portal session expired'*|*'portal returned a login page - session is dead'*)
      needs_login=1 ;;
  esac
  if (( ! needs_login )); then
    printf 'Profile %s remains selected. This error was not identified as expired or missing credentials; no login attempted.\n' "$AWS_PROFILE" >&2
    return "$auth_rc"
  fi

  sso_session="$(command aws configure get sso_session --profile "$AWS_PROFILE" 2>/dev/null)"
  sso_start_url="$(command aws configure get sso_start_url --profile "$AWS_PROFILE" 2>/dev/null)"
  credential_process="$(command aws configure get credential_process --profile "$AWS_PROFILE" 2>/dev/null)"
  if [[ -n "$sso_session" || -n "$sso_start_url" ]]; then
    login_command=(aws sso login --profile "$AWS_PROFILE")
  elif [[ -n "$credential_process" ]] && (( $+functions[awsctx_credential_login] )); then
    # Optional hook from the machine-local work file; it sets login_command
    # when it recognises the credential_process.
    awsctx_credential_login "$credential_process"
  fi
  if (( ${#login_command} == 0 )); then
    printf 'Profile %s remains selected. No supported login flow was identified; use this provider\047s normal login.\n' "$AWS_PROFILE" >&2
    return "$auth_rc"
  fi

  printf 'Run %s? [y/N] ' "${(j: :)login_command}" >&2
  if ! read -r reply || [[ "${reply:l}" != y && "${reply:l}" != yes ]]; then
    printf 'Login skipped; profile %s remains selected but is not verified.\n' "$AWS_PROFILE" >&2
    return "$auth_rc"
  fi
  command "${login_command[@]}"
  local login_rc=$?
  if (( login_rc != 0 )); then
    printf 'Login did not complete; profile %s remains selected but is not verified.\n' "$AWS_PROFILE" >&2
    return "$login_rc"
  fi
  command aws sts get-caller-identity --profile "$AWS_PROFILE" --no-cli-pager --query '{Account:Account,Arn:Arn}' --output json
}

# Infrastructure context in the terminal title, with details on demand.
# (title.zsh currently only activates in Ghostty.)
[[ -r "$HOME/.local/lib/terminal-context/title.zsh" ]] && source "$HOME/.local/lib/terminal-context/title.zsh"
