" All the settings
"
let mapleader="\<space>"
runtime macros/matchit.vim
filetype plugin on
syn on
set omnifunc=syntaxcomplete#Complete

set tabstop=4
set expandtab
set shiftwidth=4
set textwidth=0
set formatoptions+=t
set wrapmargin=79
set gdefault
set backspace=indent,eol,start
set number
set hidden
set lazyredraw
set wildmenu
set wildmode=longest:list,full
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*$py.class,*.class
set showbreak=‣
set showcmd
set completeopt+=menuone
set numberwidth=4
set encoding=utf-8
set termencoding=utf-8
set undofile
set scrolloff=3
set switchbuf=useopen
set relativenumber
set smartindent
set autoindent
set cryptmethod=blowfish2
set nojoinspaces
set ttyfast                     " smoother scrolling
set shortmess+=I                " no startup message
set shortmess-=S                " Display search result count
set matchtime=1                 " how many 10ths of a second to blink matching brackets
set wrap
set formatoptions=qrn1
set laststatus=2
set foldenable
set smartcase
set ignorecase
set incsearch
set hlsearch
set ttimeoutlen=50
set autowrite
set colorcolumn=-2
set backupcopy=yes
set nofixeol
set nofixendofline
set notimeout

if executable('rg')
    let g:ackprg = 'rg --vimgrep'
endif

let java_highlight_functions = 1
