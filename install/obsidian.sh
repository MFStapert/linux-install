#!/bin/bash

echo "Installing obsidian..."
mkdir ~/.obsidian
cd ~/.obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.13.14/obsidian_0.13.14_amd64.snap
sudo snap install --dangerous obsidian_0.13.14_amd64.snap
sudo rm -rf ~/.obsidian