# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/kp/.docker/bin"
# End of Docker Desktop section.

# Load Homebrew for login shells when available.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# PATH additions for login shells. Missing directories are skipped; duplicates
# are dropped. (.zshrc sets the full order for interactive shells.)
typeset -U path
_front=("$HOME/.local/bin" "$HOME/go/bin")
path=(${^_front}(N-/) $path)
unset _front
