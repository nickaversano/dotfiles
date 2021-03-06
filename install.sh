#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")";

function install() {
	print_only="$1";
	dir=`pwd`;
	echo $dir;
	mkdir ~/.backup;
	for f in .*; do
		if [ $f != "." ] && [ $f != ".." ] && [ $f != ".git" ] && [ $f != ".gitignore" ] && [[ $f != *.swp ]]; then
			# backup existing files
			if [ $HOME/$f -f ]; then
				cp $HOME/$f ~/.backup/$f;
			fi

			if [ $print_only ]; then
				echo "ln -sf $dir/$f $HOME/$f";
			else
				ln -sf $dir/$f $HOME/$f;
			fi
		fi 
	done

	mkdir -p ~/bin

	for f in bin/*; do
		if [ $print_only ]; then
			echo "ln -sf $dir/$f $HOME/$f"
		else
			ln -sf $dir/$f $HOME/$f
		fi
	done
	unset f;

	# commmon install stuff
	mkdir -p ~/.vim/.backup
	touch ~/.extra
	touch ~/.vimrc.local
	touch ~/.tmux.conf.local

	# get lowercase os name
	os=`echo \`uname\` | tr '[A-Z]' '[a-z]'`
  # link os-specific commands
  ln -sf $dir/.$os $HOME/.system
	# run os-specific install script (if it exists)
	if [ "${os}_install.sh" -f ]; then
		chmod +x "${os}_install.sh" && . "./${os}_install.sh"
	fi

	# install vim plugins
	vim +PlugInstall +qall

  mkdir -p $HOME/.vim
  ln -sf $dir/snippets $HOME/.vim/snippets
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	install;
elif [ "$1" == "--print" -o "$1" == "-p" ]; then
	install false;
elif [ "$1" == "--local" -o "$1" == "-l" ]; then
	install;
	# link all local files
	for f in 'local/*'; do
		ln -sf $dir/$f $HOME/$f
	done
else
	install;
fi;

