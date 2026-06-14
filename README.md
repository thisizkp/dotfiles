# dotfiles

Personal macOS laptop baseline, managed with Homebrew Bundle, GNU Stow, and
Just.

This repo installs and links the tools/configuration that make a fresh machine
feel usable day one. It is not a full project provisioner: repo-specific tools
belong with the project or workflow that needs them.

Each top-level directory is a Stow package. Files inside those packages mirror
their final paths under `$HOME`.

## New Laptop

Install Homebrew first if it is not already available:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install `just` if this is a completely fresh machine:

```sh
brew install just
```

Clone this repo:

```sh
mkdir -p "$HOME/personal"
git clone https://github.com/thisizkp/dotfiles.git "$HOME/personal/dotfiles"
cd "$HOME/personal/dotfiles"
```

Install the baseline tools and apps from `Brewfile`:

```sh
just bootstrap
```

Preview the symlinks before changing anything:

```sh
just dry-run
```

Install all dotfile packages:

```sh
just install
```

## Commands

```sh
just             # show available commands
just bootstrap   # install/update Brewfile tools and apps
just doctor      # check Brewfile and preview Stow links
just packages    # list top-level Stow packages
just dry-run     # preview symlinks
just install     # create symlinks into $HOME
just restow      # refresh existing symlinks
just uninstall   # remove symlinks managed by this repo
```

By default, Stow commands target `$HOME`. To test against another directory:

```sh
STOW_TARGET=/tmp/dotfiles-test just dry-run
```

## Boundaries

`Brewfile` is the personal machine baseline. It should include broadly useful
tools, apps, and tools required by tracked dotfiles.

Do not add every project dependency here. Install project-specific tools when a
repo or workflow asks for them.

## Conflicts

Stow will not overwrite existing files. If a file already exists on a new
machine, move it aside first:

```sh
mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
just install
```

## Secrets

Do not commit secrets, tokens, local credentials, private work setup, local app
state, machine-specific caches, or generated build artifacts.
