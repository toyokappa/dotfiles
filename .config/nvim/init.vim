" プラグイン設定
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml = '~/dotfiles/.dein.toml'
  let s:lazy_toml = '~/dotfiles/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif

" 検索/置換系の設定
set ignorecase
set smartcase
set incsearch
set wrapscan
set inccommand=split
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

" インデント系の設定
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set autoindent

" カーソル系の設定
set number
set cursorline
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start

" その他設定
set mouse=a
set clipboard+=unnamed
