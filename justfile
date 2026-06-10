set shell := ["zsh", "-cu"]

target := env_var_or_default("STOW_TARGET", env_var("HOME"))

default:
    @just --list

bootstrap:
    brew install just stow

packages:
    @find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" -exec basename {} \; | sort

dry-run:
    @packages=($(find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" -exec basename {} \; | sort)); stow --target="{{target}}" --simulate --verbose=3 "${packages[@]}"

install:
    @packages=($(find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" -exec basename {} \; | sort)); stow --target="{{target}}" "${packages[@]}"

uninstall:
    @packages=($(find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" -exec basename {} \; | sort)); stow --target="{{target}}" --delete "${packages[@]}"

restow:
    @packages=($(find . -mindepth 1 -maxdepth 1 -type d ! -name ".git" -exec basename {} \; | sort)); stow --target="{{target}}" --restow "${packages[@]}"
