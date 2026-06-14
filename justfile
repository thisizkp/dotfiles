set shell := ["zsh", "-cu"]

target := env_var_or_default("STOW_TARGET", env_var("HOME"))

default:
    @just --list

bootstrap:
    @echo "==> Checking Homebrew bundle"
    brew bundle check --file Brewfile || brew bundle install --file Brewfile

doctor:
    @echo "==> Checking Homebrew bundle"
    @brew bundle check --file Brewfile; brew_status=$?; echo "==> Previewing Stow links"; just dry-run; stow_status=$?; exit $((brew_status || stow_status))

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
