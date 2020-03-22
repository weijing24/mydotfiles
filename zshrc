# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME="random"
ZSH_THEME="kphoen"
ZSH_THEME="essembeh"
ZSH_THEME="juanghurtado"
ZSH_THEME="tjkirch"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="false"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    git                 #https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git
    git-extras
    autojump
    docker
    web-search
    encode64            # e64 d64
    # emoji
    zsh-navigation-tools
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    extract             # extract xxx.tar.gz
    # vi-mode           # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode
    zsh_reload  # src 可以 reload zshrc
    ssh		#git@github.com:zpm-zsh/ssh.git
    fzf
    mysql-colorize
    tmux
    git-open
)

source $ZSH/oh-my-zsh.sh
# Customize to your needs...
HISTSIZE=10000000
SAVEHIST=10000000
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3,bold,underline'

# _per-directory-history-set-global-history  # set per directory default to glboal

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions ]]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ssh ]]; then
    git clone https://github.com/zpm-zsh/ssh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ssh
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/mysql-colorize ]];then
    git clone https://github.com/horosgrisa/mysql-colorize ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/mysql-colorize
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open ]];then
    git clone https://github.com/paulirish/git-open.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
fi

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Add em alias for macOS
export PS1_backup=$PS1

function gitconfig_ui () {
    git config user.name jim
    git config user.email jim.wei@ui.com
}

function gitconfig_github() {
    git config user.name weijing24
    git config user.email 645509024@qq.com
}

function upgrade_custom_plugins () {
  printf "${BLUE}%s${NORMAL}\n" "Upgrading custom plugins"

  find "${ZSH_CUSTOM}" -type d -name .git | while read d
  do
    p=$(dirname "$d")
    cd "${p}"
    echo -e "${BLUE}${p}${NORMAL}"
    if git pull --rebase --stat origin master
    then
      printf "%s\n" "Hooray! $d has been updated and/or is at the current version."
    else
      printf "${RED}%s${NORMAL}\n" 'There was an error updating. Try again later?'
    fi
    echo "\n"
  done
}

function preview(){
	fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (bat --style=numbers --color=always {} ||
		cat {}) 2> /dev/null | head -500'
}
function chrome() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)"
}

alias his="history -i"
alias cat="bat"
alias sed='gsed'
alias gck='git checkout'
alias vimpluginstall="vim +PlugInstall! +qa!"
alias vimplugupdate="vim +PlugUpdate! +qa!"
alias vimplugclean="vim +PlugClean! +qa!"
alias vimplugupgrade="vim +PlugUpgrade! +qa!"
alias wget="wget -c "
alias axel="axel -a -n 5 "
alias lock="m lock"
hub version > /dev/null 2>&1 && eval "$(hub alias -s)"
exa > /dev/null 2>&1 && alias ls=exa
neofetch > /dev/null 2>&1 && alias sysinfo="neofetch"
# alias ag="ag --color-path 35 --color-match '1;35' --color-line-number 32"

# system env
export PATH="$HOME/.tgenv/bin:$PATH"
export PATH="$HOME/.tfenv/bin:$PATH"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export DISABLE_MAGIC_FUNCTIONS=true
export BAT_CONFIG_PATH="$HOME/.bat.conf"    # must use $HOME, ~ not work
# Go path for macOS
if [[ "$(uname)" == 'Darwin' ]]; then
    alias vim='/usr/local/bin/vim'
    export GOPATH=$HOME/go
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin
else
    export GOPATH=$HOME/go
    export GOROOT=/usr/lib/go
    export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin
fi
# fzf config
export FZF_BASE=/usr/local/bin/fzf
export FZF_DEFAULT_OPTS='
        --height 90% --multi --layout=reverse --border
        --bind ctrl-f:page-down,ctrl-b:page-up
        --preview-window "right:60%:wrap"
        '
#         # --preview "head -100 {}"
