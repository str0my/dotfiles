#!/bin/sh

echo "Setting up vim..."

# check if neovim installed and insert wrapper
if hash nvim2>/dev/null; then
    mkdir '~/.config/nvim/'
    cat <<'EOF' > '~/.config/nvim/init.vim'
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOF
fi

# Grab vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Fetch vimrc
curl -s https://raw.githubusercontent.com/saelo/dotfiles/master/vimrc > ~/.vimrc

# Install plugins
vim +PlugInstall +qall > /dev/null
