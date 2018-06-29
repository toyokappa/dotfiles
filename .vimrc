""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" ファイルオープン系プラグイン
Plug 'Shougo/unite.vim'
Plug 'scrooloose/nerdtree'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'

" vim拡張系プラグイン
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rhysd/migemo-search.vim'
Plug 'tpope/vim-commentary'
Plug 'Shougo/neocomplete.vim'
Plug 'glidenote/memolist.vim'

" シンタックス系プラグイン
Plug 'KeitaNakamura/railscasts.vim'
Plug 'slim-template/vim-slim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-haml'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/es.next.syntax.vim'
Plug 'vim-scripts/nginx.vim'

" Ruby開発おすすめ系プラグイン
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'

Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'heavenshell/vim-jsdoc'

call plug#end()
""""""""""""""""""""""""""""""

" matchitの設定
source $VIMRUNTIME/macros/matchit.vim
let b:match_ignorecase = 1

" 見た目
colorscheme railscasts
set t_Co=256
syntax on
set nowrap

" インデントの可視化
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=6
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=3
set autoindent
set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set backspace=indent,eol,start

" バッファ
set noswapfile
set autoread
set hidden

" 検索
set hlsearch
set ignorecase
set smartcase

" ガイドやメニューバー等
let g:lightline = {}
set laststatus=2
set ruler
set number
set wildmenu
set showcmd

" クリップボードの有効化
set clipboard+=unnamed

" インクリメント、デクリメントを16進数にする
set nf=hex

" マウスの有効化
set mouse=a

" キーマッピング
map <C-n> :NERDTreeToggle<CR>
imap <C-j> <Esc>
imap <C-e> <Esc>$
imap <C-a> <Esc>^
nmap <C-e> <Esc>$
nmap <C-a> <Esc>^
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" memolistの設定
let mapleader = ','
map <Leader>mn  :MemoNew<CR>
map <Leader>ml  :MemoList<CR>
map <Leader>mg  :MemoGrep<CR>
let g:memolist_path = "~/memolist"

" nginxのシンタックスハイライトコマンド
map <Leader>nx :set syntax=nginx<CR>

if executable('cmigemo')
  cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
endif

" =========================
" neocompleteの設定
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" =========================
" javascript-libraries-syntaxの設定
augroup MyVimrc
  autocmd!
augroup END

function! EnableJavascript()
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction
autocmd MyVimrc FileType javascript,javascript.jsx call EnableJavascript()
