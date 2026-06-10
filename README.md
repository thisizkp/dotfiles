# dotfiles

Personal macOS development setup, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a Stow package. The files inside mirror their final
paths under `$HOME`.

## New Laptop

Install the small bootstrap tools first. This assumes Homebrew is already set
up on the machine:

```sh
brew install just stow
```

Clone the repo anywhere. I usually use `~/personal/dotfiles`, but the path is
not required by the setup:

```sh
mkdir -p "$HOME/personal"
git clone https://github.com/thisizkp/dotfiles.git "$HOME/personal/dotfiles"
cd "$HOME/personal/dotfiles"
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
just              # show available commands
just packages     # list top-level Stow packages
just bootstrap    # install/update just and stow with Homebrew
just dry-run      # preview symlinks
just install      # create symlinks into $HOME
just restow       # refresh existing symlinks
just uninstall    # remove symlinks managed by this repo
```

`just install` discovers top-level package directories automatically. Keep the
repo root limited to Stow packages plus repo metadata/docs so this stays simple.

By default, commands target `$HOME`. To test against another directory:

```sh
STOW_TARGET=/tmp/dotfiles-test just dry-run
```

## Conflicts

Stow will not overwrite existing files. If a file already exists on a new
machine, move it aside first:

```sh
mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
just install
```

## Secrets

Do not commit secrets, tokens, local credentials, machine-specific app state, or
tool caches. Keep those in local config files outside this repo.
