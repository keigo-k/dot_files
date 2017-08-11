#!/bin/sh
cd $HOME
git clone https://github.com/riywo/anyenv ~/.anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
exec $SHELL -l


anyenv install rbenv
anyenv install plenv
anyenv install pyenv
anyenv install phpenv
anyenv install ndenv

source ~/.zshrc
pyenv install 2.7.9


