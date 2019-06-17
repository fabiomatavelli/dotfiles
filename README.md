# Fábio's dotfiles & setup
This is a fork of [Gil Barbara's](https://github.com/gilbarbara/dotfiles) dotfiles. This repo is mostly for me but you're welcome to make suggestions. Fork it!

## Install the necessary apps
The basic setup is executed in `setup.sh` which adds a ton of stuff: `brew` (node, mysql, python, ruby), `cask` and other stuff.

## Sensible OS X defaults
When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

## Installation

```bash
git clone https://github.com/fabiomatavelli/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./setup.sh
```

Also you can install the modules individually

```bash
./setup.sh module_name
```
Modules: apps, brew, dotfiles and fonts

To update later on, just run the install again.