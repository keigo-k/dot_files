# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="xiong-chiamiov"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler c c++ scala java python)

#User configuration

export M2_HOME="/usr/local/maven"
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export SCALA_HOME=/usr/local/src/scala

export PATH="$SCALA_HOME/bin:${M2_HOME}/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$HOME/.anyenv/bin:$HOME/bin:$PATH"
eval "$(anyenv init -)"
eval "$(pyenv virtualenv-init -)"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias gs='git status'
alias gl='git log --oneline'
alias gln='git log --name-only'
for n in $(seq 50); do
    alias gl$n="git log --oneline -n $n | tee"
done

function github-push() {
  local repository=origin
  while true; do
    if [ "$1" = -f ]; then
      local f_option=$1; shift
    elif [ "$1" = --repo ]; then
      repository=$2; shift 2
    else break; fi
  done

  local branch=${1:-$(git rev-parse --abbrev-ref HEAD)}
  local parent_branch=${2:-master}

  git push $f_option $repository $branch \
  && github-urls $branch $parent_branch
}

function github-urls() {
  local src_branch=${1:-$(git rev-parse --abbrev-ref HEAD)}
  local dst_branch=${2:-master}
  local url=$(github-push-url)

  echo "$url "
  echo "$url/tree/$src_branch "
  if [ $src_branch != $dst_branch ]; then
    echo "$url/compare/${dst_branch}...${src_branch} "
  fi
}

function github-push-url() {
  git remote -v | grep '(push)' | awk '{print $2}' | sed -e "s/^[a-z]*@\([a-z0-9\.]*\):/https:\/\/\1\//g" | sed 's/\.git$//g'
}

alias gps='github-push'

alias gdi='git diff'
alias gdn='git diff --name-only'
for n in $(seq 50); do
  alias gdi$n="git diff HEAD~$n"
  alias gdn$n="git diff --name-only HEAD~$n"
done

alias gad='git add'
alias gci='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcam='git commit --amend'

alias gco='git checkout'
alias gcot='git checkout --theirs'

alias gps='git pull'
alias gfe='git fetch'
alias gfa='git fetch --all'

export CATALINA_HOME=/usr/local/tomcat
export CUDA_ROOT=/usr/local/cuda/bin
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/leveldb:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/hdf5/lib:$LD_LIBRARY_PATH

alias py36="source ~/.anyenv/envs/pyenv/versions/py36/bin/activate"

CPATH=/usr/local/cuda/include
C_INCLUDE_PATH=/usr/local/cuda/include
CPLUS_INCLUDE_PATH=/usr/local/cuda/include

ssh-add >& /dev/null


LANG=C
#/usr/bin/setxkbmap -option ctrl:swapcaps,caps:ctrl_modifier,terminate:ctrl_alt_bksp

if [ -e /etc/os-release -a -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
