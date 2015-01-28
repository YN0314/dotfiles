" Vim互換
set nocompatible
filetype off
filetype plugin indent off

" Neobundle
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'altercation/vim-colors-solarized'

" slim syntax highlight
NeoBundle 'slim-template/vim-slim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" バックアップファイルを作らない
set nobackup
" swpファイルを作らない
set noswapfile

" タブとインデント
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent

" 行番号を表示する
set number

" Colorscheme set up
syntax enable
set background=dark
colorscheme solarized

"" Unite.vim {
" The prefix key. \+u
nnoremap [unite] <Nop>
nmap <Space>u [unite]

" unite.vim keymap
nnoremap [unite]bf :<C-u>Unite buffer<CR>
nnoremap [unite]fr :<C-u>Unite file_rec<CR>
nnoremap [unite]bm :<C-u>Unite bookmark<CR>
nnoremap [unite]fm :<C-u>Unite file_mru<CR>
" }

" reload vimrc
nnoremap <Space>s  :<C-u>source $VIMRC<CR>

" 環境別設定
if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

filetype on

" scss systax highlight
au BufRead,BufNewfile *.scss set filetype=sass


