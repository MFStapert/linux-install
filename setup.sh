#!/bin/bash
user_home=$HOME
path=$(realpath $0)
dir=$(dirname $path)

# add proper check
sudo -v
sudo apt-get update

apt_to_install=$(grep -v '^\s*$\|^\s*\#' $dir/packages/apt.txt)
echo "Trying to install apt packages..."

while read -r pkg; do
  echo "Installing $pkg..."
  sudo apt-get install -y $pkg > /dev/null
done <<< "$apt_to_install"


apt_to_remove=$(grep -v '^\s*$\|^\s*\#' $dir/packages/apt_uninstall.txt | tr "\n" " ")
echo "Found the following apt packages to remove: $apt_to_remove"

echo "Trying to uninstall apt packages..."
sudo apt-get remove -y $apt_to_remove > /dev/null
sudo apt-get autoremove -y > /dev/null

snap_to_install=$(grep -v '^\s*$\|^\s*\#' $dir/packages/snap.txt)
echo "Trying to install snap packages..."

while read -r pkg; do
    echo "Installing $pkg..."
    sudo snap install $pkg > /dev/null
done <<< "$snap_to_install"

echo "Trying standalone installs..."
find "$dir/install" -type f -name '*.sh' -exec bash {} \;

# stow dotfiles
echo "stowing dotfiles..."
sudo stow dotfiles --target=$HOME

# asdf post install
echo "asdf post install..."
$HOME/.asdf/bin/asdf plugin-add nodejs
$HOME/.asdf/bin/asdf install

echo "done"