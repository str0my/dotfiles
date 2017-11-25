#!/bin/sh

echo "Setting up zsh..."

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
curl -s https://raw.githubusercontent.com/str0my/dotfiles/master/.zshrc > ~/.zshrc
curl -s https://raw.githubusercontent.com/str0my/dotfiles/master/themes/stromy.zsh-theme > ~/.oh-my-zsh/themes/stromy.zsh-theme

# needs sudo to work passwordless
sudo chsh -s $(which zsh) $(whoami)
