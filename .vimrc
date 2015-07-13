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
  Plugin 'nanotech/jellybeans.vim'
  Plugin 'airblade/vim-gitgutter'

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
set foldmethod=indent
set foldlevel=1
set t_Co=256
set ttimeoutlen=50
set relativenumber

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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
  if isdirectory($HOME . "/.vim/bundle/fonts")
    let g:airline_powerline_fonts = 1
  endif
  "function! AirlineInit()
    "let g:airline_section_a = airline#section#create(['mode',' ','branch'])
    "let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
    "let g:airline_section_c = airline#section#create(['filetype'])
    "let g:airline_section_x = airline#section#create(['%P'])
    "let g:airline_section_y = airline#section#create(['%B'])
    "let g:airline_section_z = airline#section#create_right(['%l','%c'])
  "endfunction
  "autocmd VimEnter * call AirlineInit()
endif

"---------------------------------------
" Airline settings
"---------------------------------------
if isdirectory($HOME . "/.vim/bundle/jellybeans.vim")
  colo jellybeans
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

