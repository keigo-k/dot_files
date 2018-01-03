#!/bin/sh
set -e

sudo echo "The commands with sudo will be executed!"
DOT_DIR=`dirname $0`
cd $HOME

ssh-keygen -t rsa
chmod 700 -R ~/.ssh
eval `ssh-agent`
ssh-add

if [ -e /etc/redhat-release ]; then
    sudo yum install zsh gcc gcc-c++ git vim zlib-devel screen \
        GConf2 tree bzip2-devel openssl-devel \
        zlib-devel readline-devel sqlite3 sqlite-devel \
        llvm llvm-devel clang clang-devel
    sudo cp /etc/localtime /etc/localtime.org
    sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
    sudo localectl set-locale LANG=ja_JP.UTF-8
fi

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
if [ -e ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.bak
fi
ln -s $DOT_DIR/.zshrc ~/.zshrc

mkdir -p ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
if [ -e ~/.vimrc ]; then
    cp ~/.vimrc ~/.vimrcrc.bak
fi
ln -s $DOT_DIR/.vimrc ~/.vimrc

if [ -e ~/.screenrc ]; then
    cp ~/.screenrc ~/.screenrc.bak
fi
ln -s $DOT_DIR/.screenrc .screenrc

if [ -e ~/.gitconfig ]; then
    cp ~/.gitconfig ~/.gitconfig.bak
fi
ln -s $DOT_DIR/.gitconfig ~/.gitconfig

if [ -e ~/.clang-format.py ]; then
    cp ~/.clang-format.py ~/.clang-format.py.bak
fi
ln -s $DOT_DIR/.clang-format.py ~/.clang-format.py


git clone https://github.com/riywo/anyenv ~/.anyenv
anyenv install rbenv
anyenv install plenv
anyenv install pyenv
anyenv install phpenv
anyenv install ndenv
source ~/.zshrc
pyenv install 3.6.2
pyenv global 3.6.2
git clone https://github.com/pyenv/pyenv-virtualenv.git \
    ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
pyenv virtualenv 3.6.2 py36

