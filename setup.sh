#!/usr/bin/env bash

libs=(apps brew dotfiles fonts)

source ./lib/utils
# Source the necessary files and helper scripts
for i in "${libs[@]}"; do
    source ./lib/$i
done

if array_contains "$1" "${libs[@]}"; then

    seek_confirmation "Do you want to install $1"

    if is_confirmed; then
        run_$1
    fi
    exit
else
  seek_confirmation "Do you want to proceed with the installation"

  if ! is_confirmed; then
    exit
  fi
fi

sudo -v

git pull

# Before relying on Homebrew, check that packages can be compiled
if ! type_exists 'gcc'; then
    e_error "The XCode Command Line Tools must be installed first."
    printf "  run 'xcode-select --install' and follow the instrucctions\n"
    printf "  Then run this setup script again.\n"
    exit 1
fi

# Check for Homebrew
if ! type_exists 'brew'; then
    e_process "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

e_process "Installing Homebrew packages"
run_brew

# Ask before potentially overwriting files
seek_confirmation "Overwrite your existing dotfiles"

if is_confirmed; then
    # Symlink all necessary files

    run_dotfiles

    e_success "All files have been symlinked"

else
    e_error "This step is required.  When you're ready, run this script to start up again"
fi

# Ask installing OS X Applications?
seek_confirmation "Do you want to install Mac OS X Apps and stuff"

if is_confirmed; then

    e_process "Installing Mac OS X Applications"
    run_apps

    e_process "Installing Mac OS X fonts"
    run_fonts

    e_success "All Mac OS X Applications have been installed"

    e_warning "Please consider using cask commands for Updating/Upgrading or Uninstalling a Mac OS X Application"
fi

# Ask installing zsh?
seek_confirmation "Do you want to install Zsh"

if is_confirmed; then
    e_process "Installing Zsh"
    
    # Install zsh
	brew install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	chsh -s $(which zsh)
fi

e_success "Your Mac is ready to rock!"
