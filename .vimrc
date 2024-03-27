set backspace=2         " backspace in insert mode works like normal editor
syntax on               " syntax highlighting
filetype indent on      " activates indenting for files
set number              " line numbers
colorscheme desert      " colorscheme desert
set nobackup            " get rid of anoying ~file
set expandtab           " Convert tabs to spaces
set tabstop=4           " <TAB> four spaces
set shiftwidth=4        " Shift width four spaces (for auto indent)
set noautoindent        " Turn off autoindent by default
set smartindent         " Use smart indent instead
set incsearch           " Use incremental searches (cool)
set ruler               " Show position of cursor in status line
set showmatch           " Show matching parens/braces when writing code
set wh=55               " Minimum window height
set t_Co=256            " 256 colors in terminal
highlight ColorColumn  ctermbg=232
let &colorcolumn="80,".join(range(81,999),",")

" Speed up response to ESC key
set notimeout
set ttimeout
set timeoutlen=100

" Make completion more like bash
set wildmode=longest,list
