# zplugの設定-------------------
export ZPLUG_HOME=~/dotfiles/.zplug
if [[ ! -d $ZPLUG_HOME ]]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

# zplugを使う
source $ZPLUG_HOME/init.zsh

# 自分自身をプラグインとして管理
zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "chrissicool/zsh-256color"
zplug "Tarrasch/zsh-colors"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "ascii-soup/zsh-url-highlighter"

zplug 'mafredri/zsh-async', from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme

# インストールしてないプラグインはインストール
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load

# 基本的な設定------------------
export EDITOR=nvim
autoload -Uz colors; colors

setopt nobeep
setopt mark_dirs
setopt correct
setopt correct_all

export LANG=ja_JP.UTF-8
setopt share_history
setopt hist_ignore_dups
HISTFILE=~/dotfiles/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプトの設定---------------
autoload -Uz promptinit; promptinit

zstyle ':prompt:pure:path' color white
zstyle ':prompt:pure:prompt:*' color cyan
zstyle ':prompt:pure:git:stash' show yes

# 補完関連の設定-----------------
autoload -Uz compinit; compinit

# 補完候補の表示設定
setopt complete_in_word
setopt auto_list
unsetopt auto_menu

# エイリアスの設定-----------------
alias ls='ls -G' # lsで色を付ける
alias vim='nvim'
alias fig='docker-compose'

alias vimconf='vim ~/dotfiles/.config/nvim/init.vim'
alias zshconf='vim ~/dotfiles/.zshrc'

function chpwd() { ls } # cd後にlsを実行

# nodeの設定
eval "$(nodenv init -)"
