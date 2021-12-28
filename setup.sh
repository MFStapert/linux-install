#!/bin/bash
user_home=$HOME
path=$(realpath $0)
dir=$(dirname $path)

sudo -v
if [[ $(id -u) -ne 0 ]]
  then echo "Please run as root"
  exit
fi

apt_to_install=$(grep -v '^\s*$\|^\s*\#' $dir/packages/apt.txt | tr "\n" " ")
echo "Found the following apt packages to install: $apt_to_install"

sudo apt-get update
echo "Trying to install apt packages..."
sudo apt-get install -y $apt_to_install

apt_to_remove=$(grep -v '^\s*$\|^\s*\#' $dir/packages/apt_uninstall.txt | tr "\n" " ")
echo "Found the following apt packages to remove: $apt_to_remove"

echo "Trying to uninstall apt packages..."
sudo apt-get remove -y $apt_to_remove
sudo apt autoremove -y

snap_to_install=$(grep -v '^\s*$\|^\s*\#' $dir/packages/snap.txt)
echo "Trying to install snap packages..."

while read -r pkg; do
    sudo snap install $pkg
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