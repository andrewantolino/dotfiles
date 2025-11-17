# Personal `dotfile` repository

My dotfiles. Symlinks managed by [`stow`](https://www.gnu.org/software/stow/).

See [this blog post by Alex Pearce](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/) for
more info on using `stow` to manage dotfiles.

## Prerequisites

`git`, `brew` and `stow` installed on machine.

## Setup instructions

1. `git clone git@github.com:andrewantolino/dotfiles.git ~/.dotfiles`
1. `cd ~/.dotfiles`
1. `stow ${packageName}`

### Setup with Brewfile & Makefile

This repository includes a **Brewfile** and a **Makefile** to automate setting up your development environment on macOS.

#### Brewfile

- Declaratively lists all software, including:
  - CLI tools (`brew "..."`)  
  - GUI apps (`cask "..."`)  
  - VS Code extensions (`vscode "..."`)  
  - Go tools (`go "..."`)  
- Run to install everything at once:

    brew bundle --file Brewfile

---

#### Makefile

Provides convenient commands for reproducible setup:

| Target            | Description                                                      |
|------------------|------------------------------------------------------------------|
| `make bootstrap`  | Installs all Brewfile items                                       |
| `make update`     | Updates Homebrew, upgrades packages, and reinstalls Brewfile items |
| `make cleanup`    | Removes Homebrew packages not listed in Brewfile                  |
| `make vscode-cli` | Adds the `code` command to your PATH for VS Code                 |
| `make go-tools`   | Ensures Go tools binaries are on your PATH                        |
| `make all`        | Runs bootstrap + vscode-cli + go-tools in one step                |

Example usage on a new Mac:

    git clone <repo-url> ~/.dotfiles
    cd ~/.dotfiles
    make all

> After this, your machine will have all CLI tools, GUI apps, VS Code extensions, and Go tools installed and ready to use.
