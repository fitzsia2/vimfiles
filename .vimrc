"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
" Vundle setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
set hls
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/macros/
call vundle#rc()

" This is the Vundle package, which can be found on GitHub
" For GitHub repos, you can specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'
Plugin 'fatih/vim-go'

" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'

" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
Plugin 'Buffergator'

Plugin 'cscope'

" No we can turn our filetype functionality back on
filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
" Custom Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
set smarttab
set autoindent
set softtabstop=2
set shiftwidth=2
set tabstop=2
" Use spaces instead of tabs
set expandtab
colorscheme desert
set guifont=monospace\ 13
set number
set ignorecase
set vb " turns off visual bell
set nowrap
set foldmethod=indent
set so=7

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Tell vim to remember certain things when we exit a file
"   '10  :  marks will be remember forup to 10 previously edited files
"   "100 :  will save up to 100 lines for each register
"   :20  :  up to 20 lines of command-line history
"   %    :  saves and restores the buffer list
"   n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Autoload cscope DB file
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if(!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

