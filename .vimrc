filetype off
filetype plugin indent off

" Install neobundle if neobundle not installed.
if ! isdirectory(expand('~/.vim/bundle'))
  echon 'Installing neobundle.vim...'
  silent call mkdir(expand('~/.vim/bundle'), 'p')
  silent call system('git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
  echo 'done.'
  if v:shell_error
    echoerr 'neobundle.vim installation has failed!'
    finish
  endif
endif

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

NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'tpope/vim-endwise'

NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'itchyny/lightline.vim'

" slim syntax highlight
NeoBundle 'slim-template/vim-slim'

" color scheme
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'sheerun/vim-wombat-scheme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'

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

" ステータスラインを常に表示
set laststatus=2

" Colorscheme set up
syntax on
set background=dark
" colorscheme solarized
let g:hybrid_use_Xresources = 1
colorscheme hybrid
"colorscheme wombat

"" Unite.vim {
" The prefix key. \+u
nnoremap [unite] <Nop>
nmap <Space>u [unite]

" unite.vim keymap
nnoremap [unite]bf :<C-u>Unite buffer<CR>
nnoremap [unite]fr :<C-u>Unite file_rec<CR>
nnoremap [unite]bm :<C-u>Unite bookmark<CR>
nnoremap [unite]fm :<C-u>Unite file_mru<CR>

let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
" }

" reload vimrc
nnoremap <Space>s  :<C-u>source $VIMRC<CR>

let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

augroup MyIndentGuides
  autocmd!
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240
augroup END

function! GitBranchName() " {{{
  try
    if exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? _ : ''
    endif
  catch
  endtry
  return ''
endfunction " }}}

let g:lightline = {
  \   'Colorscheme': 'hybrid',
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['git_branch_name', 'readonly', 'filename', 'modified']
  \     ]
  \   },
  \   'component_function': {
  \     'git_branch_name': 'GitBranchName'
  \   }
  \ }

" 環境別設定
if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

filetype on

" scss systax highlight
au BufRead,BufNewfile *.scss set filetype=sass

" modify row numbers color
hi LineNr ctermbg=0 ctermfg=0
hi CursorLineNr ctermbg=4 ctermfg=0
set cursorline
hi clear CursorLine

