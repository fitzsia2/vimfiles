"---------------------------------------
" Setup Vundle and plugins
"---------------------------------------
if isdirectory($HOME . "/.vim/bundle/Vundle.vim")
  set nocompatible
  filetype off

  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'gmarik/Vundle.vim'
  Plugin 'scrooloose/syntastic'
  Plugin 'scrooloose/nerdtree'
  Plugin 'Buffergator'
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-easytags'
  Plugin 'bling/vim-airline'
  Plugin 'powerline/fonts'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'tpope/vim-fugitive'
  Plugin 'idbrii/vim-man'
  Plugin 'nanotech/jellybeans.vim'
  Plugin 'altercation/vim-colors-solarized'

  call vundle#end()
  filetype plugin indent on
endif

"---------------------------------------
" Custom settings
"---------------------------------------
colorscheme desert
syntax on
set number
set bg=dark
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set autoindent
set nowrap
set scrolloff=3
set ruler
set showcmd
set showmode
set incsearch
set hls
set foldmethod=syntax
set foldlevel=2
set t_Co=256
set ttimeoutlen=50
set relativenumber

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

filetype indent on

"---------------------------------------
" Custom settings
"---------------------------------------
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
  set noexpandtab
  set ts=4
  set sw=4
endif

"---------------------------------------
" vim-man settings
"---------------------------------------
if isdirectory($HOME . "/.vim/bundle/vim-man")
  nnoremap K :Man <cword>
else
  echo "no vim-man"
end

"---------------------------------------
" Syntastic settings
"---------------------------------------
if has("Syntastic")
  let g:statline_syntastic = 0
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  set statusline+=%F
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif

"---------------------------------------
" CScope settings
"---------------------------------------
if has("cscope")
  function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
      let path = strpart(db, 0, match(db, "/cscope.out$"))
      set nocscopeverbose " suppress 'duplicate connection' error
      exe "cs add " . db . " " . path
      set cscopeverbose
    endif
  endfunction
  au BufEnter /* call LoadCscope()

  nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>
endif

"---------------------------------------
" tag settings
"---------------------------------------
nmap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
function! ReloadTags()
  exe "!ctags -R $(ls *.c *.h)"
endfunction

"---------------------------------------
" Airline settings
"---------------------------------------
if isdirectory($HOME . "/.vim/bundle/vim-airline")
  set laststatus=2
  let g:airline#extensions#bufferline#enabled = 1
  let g:airline#extensions#bufferline#overwrite_variables = 1
  if isdirectory($HOME . "/.vim/bundle/fonts")
    let g:airline_powerline_fonts = 1
  endif

  if isdirectory($HOME . "/.vim/bundle/fugitive")
    " enable/disable fugitive/lawrencium integration
    let g:airline#extensions#branch#enabled = 1

    " change the text for when no branch is detected
    let g:airline#extensions#branch#empty_message = ''

    " use vcscommand.vim if available
    let g:airline#extensions#branch#use_vcscommand = 0

    " truncate long branch names to a fixed length
    let g:airline#extensions#branch#displayed_head_limit = 10

    " customize formatting of branch name
    " default value leaves the name unmodifed
    let g:airline#extensions#branch#format = 0

    " to only show the tail, e.g. a branch 'feature/foo' show 'foo'
    let g:airline#extensions#branch#format = 1

    " if a string is provided, it should be the name of a function that
    " takes a string and returns the desired value
    let g:airline#extensions#branch#format = 'CustomBranchName'
    function! CustomBranchName(name)
      return '[' . a:name . ']'
    endfunction

    leg g:airline#extensions#tabline#enabled = 1

    " enable/disable syntastic integration >
    let g:airline#extensions#syntastic#enabled = 0
  endif
endif

"---------------------------------------
" Airline settings
"---------------------------------------
if isdirectory($HOME . "/.vim/bundle/jellybeans.vim")
  let g:jellybeans_background_color_256='NONE'
  colo jellybeans
  set colorcolumn=80
endif

"---------------------------------------
" minitest highlighting
"---------------------------------------
if isdirectory($HOME . "/.vim/autoload/after")
  set completefunc=syntaxcomplete#Complete
endif

"---------------------------------------
" Tell vim to remember certain things when we exit a file
"   '10  :  marks will be remember forup to 10 previously edited files
"   "100 :  will save up to 100 lines for each register
"   :20  :  up to 20 lines of command-line history
"   %    :  saves and restores the buffer list
"   n... :  where to save the viminfo files
"---------------------------------------
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

