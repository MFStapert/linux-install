#!/bin/bash

echo "Installing dropbox..."
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -$HOME/.dropbox-dist/dropboxd & sudo apt-get install nautilus-dropbox -y