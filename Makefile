slave: clean-slave
	ln -s ${HOME}/.dotfiles/bashrc ${HOME}/.bashrc
	ln -s ${HOME}/.dotfiles/ctfrc ${HOME}/.ctfrc
	ln -s ${HOME}/.dotfiles/toolsrc ${HOME}/.toolsrc
	ln -s ${HOME}/.dotfiles/gdbinit ${HOME}/.gdbinit
	ln -s ${HOME}/.dotfiles/gef.rc ${HOME}/.gef.rc
	ln -s ${HOME}/.dotfiles/gef-scripts ${HOME}/.gef-scripts
	ln -s ${HOME}/.dotfiles/pythonrc ${HOME}/.pythonrc
	ln -s ${HOME}/.dotfiles/tmux.conf ${HOME}/.tmux.conf
	ln -s ${HOME}/.dotfiles/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim/
	ln -s ${HOME}/.dotfiles/vim-snippets ${HOME}/.vim/snippets
	vim +PlugInstall +qall > /dev/null

master: clean-master
	git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
	ln -s ${HOME}/.dotfiles/zshrc ${HOME}/.zshrc 
	ln -s ${HOME}/.dotfiles/themes/stromy.zsh-theme ${HOME}/.oh-my-zsh/themes/stromy.zsh-theme
	ln -s ${HOME}/.dotfiles/ctfrc ${HOME}/.ctfrc
	ln -s ${HOME}/.dotfiles/pythonrc ${HOME}/.pythonrc
	ln -s ${HOME}/.dotfiles/tmux.conf ${HOME}/.tmux.conf
	ln -s ${HOME}/.dotfiles/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim/
	ln -s ${HOME}/.dotfiles/vim-snippets ${HOME}/.vim/snippets
	vim +PlugInstall +qall > /dev/null

clean-master:
	rm -rf ${HOME}/.oh-my-zsh/themes/stromy.zsh-theme
	rm -rf ${HOME}/.oh-my-zsh
	rm -rf ${HOME}/.zshrc
	rm -rf ${HOME}/.bashrc
	rm -rf ${HOME}/.ctfrc
	rm -rf ${HOME}/.toolsrc
	rm -rf ${HOME}/.pythonrc
	rm -rf ${HOME}/.tmux.conf
	rm -rf ${HOME}/.vimrc
	rm -rf ${HOME}/.vim/snippets

clean-slave:
	rm -rf ${HOME}/.oh-my-zsh/themes/stromy.zsh-theme
	rm -rf ${HOME}/.zshrc
	rm -rf ${HOME}/.bashrc
	rm -rf ${HOME}/.ctfrc
	rm -rf ${HOME}/.toolsrc
	rm -rf ${HOME}/.gdbinit
	rm -rf ${HOME}/.gef.rc
	rm -rf ${HOME}/.gitconfig
	rm -rf ${HOME}/.gef-scripts
	rm -rf ${HOME}/.pythonrc
	rm -rf ${HOME}/.tmux.conf
	rm -rf ${HOME}/.vimrc
	rm -rf ${HOME}/.vim/snippets
