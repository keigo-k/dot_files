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
    mkdir -p ~/git
    sudo cp /etc/localtime /etc/localtime.org
    sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
    sudo localectl set-locale LANG=ja_JP.UTF-8
else
    sudo apt-get install zsh gcc g++ vim screen git gconf2
    mkdir -p ~/git
    cd ~/git
    git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git
    cd gnome-terminal-colors-solarized
    ./set_dark.sh
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#00002B2B3636"
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#65657B7B8383"
    curl -fL https://raw.github.com/seebi/dircolors-solarized/master/dircolors.256dark > ~/.dircolors
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

