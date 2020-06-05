" プラグイン設定
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/dotfiles/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml = '~/dotfiles/.config/nvim/dein/.dein.toml'
  let s:lazy_toml = '~/dotfiles/.config/nvim/dein/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install(['vimproc.vim'])
  call dein#install(['vimproc.vim'])
endif

if dein#check_install()
  call dein#install()
endif

" 見た目
colorscheme iceberg
set t_Co=256
syntax on
set nowrap

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
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=7
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8

" カーソル系の設定
set number
set cursorline
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start

" その他設定
set mouse=a
set clipboard+=unnamed
nnoremap <silent><C-n> :NERDTreeToggle<CR>
