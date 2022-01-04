#!/bin/bash
user_home=$HOME
path=$(realpath $0)
dir=$(dirname $path)

if [ "$EUID" == 0 ]; 
then
    echo "This script shouldn't be ran as root"
    exit;
else 
  sudo -v
fi

sudo apt-get update

apt_to_install=$(grep -v '^\s*$\|^\s*\#' $dir/packages/apt.txt)
echo "Trying to install apt packages..."

while read -r pkg; do
  echo "Installing $pkg..."
  sudo apt-get install -y $pkg > /dev/null
done <<< "$apt_to_install"


apt_to_remove=$(grep -v '^\s*$\|^\s*\#' $dir/packages/apt_uninstall.txt | tr "\n" " ")
echo "Trying to uninstall apt packages..."
while read -r pkg; do
  echo "Uninstalling $pkg..."
  sudo apt-get remove -y $apt_to_remove > /dev/null
done <<< "$apt_to_remove"

sudo apt-get autoremove -y > /dev/null

snap_to_install=$(grep -v '^\s*$\|^\s*\#' $dir/packages/snap.txt)
echo "Trying to install snap packages..."

while read -r pkg; do
    echo "Installing $pkg..."
    sudo snap install $pkg > /dev/null
done <<< "$snap_to_install"

echo "Trying standalone installs..."
find "$dir/install" -type f -name '*.sh' -exec bash {} > /dev/null \; \

# stow dotfiles
echo "stowing dotfiles..."
sudo stow dotfiles --target=$HOME

# asdf post install
echo "asdf install..."
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
$HOME/.asdf/bin/asdf plugin-add nodejs
$HOME/.asdf/bin/asdf install

echo "done"