set shell := ["zsh", "-cu"]

target := env_var_or_default("STOW_TARGET", env_var("HOME"))

default:
    @just --list

installed-cask-skip:
    @skip=(); \
    [[ -d "/Applications/Ghostty.app" || -d "$HOME/Applications/Ghostty.app" ]] && skip+=(ghostty); \
    [[ -d "/Applications/Google Chrome.app" || -d "$HOME/Applications/Google Chrome.app" ]] && skip+=(google-chrome); \
    [[ -d "/Applications/Obsidian.app" || -d "$HOME/Applications/Obsidian.app" ]] && skip+=(obsidian); \
    [[ -d "/Applications/Raycast.app" || -d "$HOME/Applications/Raycast.app" ]] && skip+=(raycast); \
    [[ -d "/Applications/Slack.app" || -d "$HOME/Applications/Slack.app" ]] && skip+=(slack); \
    [[ -d "/Applications/Spotify.app" || -d "$HOME/Applications/Spotify.app" ]] && skip+=(spotify); \
    [[ -d "/Applications/Discord.app" || -d "$HOME/Applications/Discord.app" ]] && skip+=(discord); \
    [[ -d "/Applications/Docker.app" || -d "$HOME/Applications/Docker.app" ]] && skip+=(docker-desktop); \
    print -r -- "${skip[*]}"

bootstrap:
    @echo "==> Checking Homebrew bundle"
    @cask_skip="$(just installed-cask-skip)"; if [[ -n "$cask_skip" ]]; then echo "==> Skipping already-installed casks: $cask_skip"; fi; HOMEBREW_BUNDLE_CASK_SKIP="$cask_skip" brew bundle check --file Brewfile || HOMEBREW_BUNDLE_CASK_SKIP="$cask_skip" brew bundle install --file Brewfile --no-upgrade

doctor:
    @echo "==> Checking Homebrew bundle"
    @cask_skip="$(just installed-cask-skip)"; if [[ -n "$cask_skip" ]]; then echo "==> Skipping already-installed casks: $cask_skip"; fi; HOMEBREW_BUNDLE_CASK_SKIP="$cask_skip" brew bundle check --file Brewfile; brew_status=$?; echo "==> Previewing Stow links"; just dry-run; stow_status=$?; exit $((brew_status || stow_status))

packages:
    @find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" ! -name "target" -exec basename {} \; | sort

dry-run:
    @packages=($(find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" ! -name "target" -exec basename {} \; | sort)); stow --target="{{target}}" --simulate --verbose=3 "${packages[@]}"

install:
    @packages=($(find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" ! -name "target" -exec basename {} \; | sort)); stow --target="{{target}}" "${packages[@]}"

uninstall:
    @packages=($(find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" ! -name "target" -exec basename {} \; | sort)); stow --target="{{target}}" --delete "${packages[@]}"

restow:
    @packages=($(find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" ! -name "target" -exec basename {} \; | sort)); stow --target="{{target}}" --restow "${packages[@]}"
