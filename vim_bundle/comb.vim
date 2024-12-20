autocmd FileType html set spell
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd FileType python set omnifunc=python3complete#Complete

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType phtml set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType sql set omnifunc=sqlcomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}}


" Activate Limelight when we enter Goyo.
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif
if &listchars ==# 'eol:$'
	set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
	if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
		let &listchars = "tab:\u2023\u2027,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
	endif
endif

" go back to previous position on open
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" rename the current file
" https://github.com/r00k/dotfiles/blob/master/vimrc
function! RenameFile()
	let old_name = expand('%')
	let new_name = input('New file name: ', expand('%'), 'file')
	if new_name != '' && new_name != old_name
		exec ':saveas ' . new_name
		exec ':silent !rm ' . old_name
		redraw!
	endif
endfunction
map <Leader>n :call RenameFile()<cr>

function! DOS2UNIX()
	update
	e ++ff=dos
	setlocal ff=unix
	w
endfunction
map <Leader>u :call DOS2UNIX()<cr>


" Periodical auto-save
" Write to disk after 1 second of inactivity, once every 15 seconds.
au BufRead,BufNewFile * let b:last_autosave=localtime()
au CursorHold * call UpdateFile()
au BufWritePre * let b:last_autosave=localtime()
set updatetime=1000
function! UpdateFile()
	if exists("b:last_autosave") && ((localtime() - b:last_autosave) >= 15)
		update
		let b:last_autosave=localtime()
	endif
endfunction

set timeout timeoutlen=1000 ttimeoutlen=100


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

let g:ctrlp_open_new_file = 'h'
nnoremap ,b :CtrlPBufTag<CR>
nnoremap ,m :CtrlPMRUFiles<CR>
nnoremap ,t :CtrlPTag<CR>
nnoremap ,d :CtrlPDir<CR>
nnoremap ,g :CtrlPBuffer<CR>
nnoremap ,l :CtrlPLine<CR>
nnoremap ,c :CtrlPChange<CR>
let g:ctrlp_custom_ignore = { 'dir': 'node_modules\|bower_components\|public\|cache' }
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
map ,f :FZF<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,m :History<CR>
nnoremap ,k :Marks<CR>
nnoremap ,t :Tags<CR>
nnoremap ,g :BTags<CR>
nnoremap ,l :Lines<CR>
nnoremap ,bl :BLines<CR>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" let g:fzf_layout = { 'up': '~80%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10split enew' }
" 
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! HandleFZF(file)
    echo a:file
endfunction
command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)


" KEYBOARD MAPPINGS {{{
let g:NumberToggleTrigger="<F2>"
nmap <silent> <leader>s :set nolist!<CR>
nmap <silent> <Leader>cd :lcd %:p:h<CR>
" global copy/paste
nmap <leader>y "+yy
nmap <leader>p "+p
nmap ,D "_dd " does not put into register
" sort things
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>q gqip
nnoremap <leader>v V`]
nnoremap j gj
nnoremap k gk
noremap '. `.
noremap `. '.
" Quickfix navigation
nmap cn :cnext<cr>
nmap cp :cprev<cr>
nmap bn <esc>:bn<cr>
nmap bp <esc>:bp<cr>
" Redraw screen and remove search highlights
nnoremap <silent> <BS> :nohl<cr><c-l>
" Start search with word under cursor
nmap ,z :%s/<c-r><c-w>/
vmap ,z :<c-u>%s/<c-r>*/
map ,w <esc>:w<cr>
map <Leader>r <esc>:reg<cr>
map ,bd <esc>:bd<cr>
"Pressing ,ss will toggle and untoggle spell checking
map ,ss :setlocal spell!<cr>
" Yep ... no more up keys
map <UP> <esc>
map <DOWN> <esc>
map <LEFT> <esc>:Vista!!<cr>
nnoremap <RIGHT> :UndotreeToggle<CR>
" update tag file/headless make/display errors
map <Leader>c :Copen<cr>
map <Leader>e :Errors<cr>
map <Leader>k :make<cr>
map <Leader>d :Make! dev<cr>
" Prints date and time
map <leader>dt :r! date +"// +\%Y-\%m-\%d \%H:\%M:\%S"<cr><cr>
map <leader>dT :r! date +"%d %h, %a"<cr><cr>
"}}}
"
" Activate Goya with \<Space>
" 
nnoremap <Leader>\ :Goyo<CR>
map ,e <esc>:NERDTreeToggle<CR>

map <Space>m <esc>15<c-w><c-+>
 if has("lua")
 	let g:acp_enableAtStartup = 0
 	let g:neocomplete#enable_at_startup = 1
 	let g:neocomplete#enable_smart_case = 1
 	let g:neocomplete#sources#syntax#min_keyword_length = 3
 	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

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
 	  return neocomplete#smart_close_popup() . "\<CR>"
 	  " For no inserting <CR> key.
 	  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
 	endfunction
 	" <TAB>: completion.
 	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
 	" <C-h>, <BS>: close popup and delete backword char.
 	inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
 	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
 	inoremap <expr><C-y>  neocomplete#close_popup()
 	inoremap <expr><C-e>  neocomplete#cancel_popup()
	"
 	" Enable omni completion.
 	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
 	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
 	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
 	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
 	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
 	autocmd FileType php setlocal omnifunc=phpcomplete#CompleteTags

 	" Enable heavy omni completion.
 	 if !exists('g:neocomplete#sources#omni#input_patterns')
 	   let g:neocomplete#sources#omni#input_patterns = {}
 	 endif
	"
 	" For perlomni.vim setting.
 	" https://github.com/c9s/perlomni.vim
 	let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
 endif
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0


let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:jsx_ext_required = 0

" Overwrite some Goya defaults
let g:goyo_width = 105
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2

" Vista
let g:vista_fzf_preview = ['right:50%']

let g:rooter_patterns = ['build.gradle', 'package.json', '.git/', 'cargo.toml']
let python_highlight_all = 1

let g:ale_linters = {'rust': ['analyzer']}
let g:ale_fixers = {'rust': ['rustfmt']}
let g:ale_completion_enabled = 1

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
set omnifunc=ale#completion#OmniFunc
let g:rainbow_active = 1

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> , :WhichKey ','<CR>
set timeoutlen=500
" {{{ paths
if $APPDATA != ''
	let rootpath=$APPDATA . "/vim"
	let undopath=rootpath . "/undo"
	let swappath=rootpath . "/swap"
	let backuppath=rootpath . "/backups"

	if !isdirectory(rootpath)
		call mkdir(undopath, 'p')
		call mkdir(swappath)
	else
		if !isdirectory(swappath)
			call mkdir(swappath)
		endif
		if !isdirectory(undopath)
			call mkdir(undopath)
		endif
		if !isdirectory(backuppath)
			call mkdir(backuppath)
		endif
	endif

	let f=fnameescape(swappath)
	exec "set directory=".f

	let f=fnameescape(undopath)
	exec "set undodir=".f

	let f=fnameescape(backuppath)
	exec "set backupdir=".f
else
	if !isdirectory($HOME . '/tmp/vim')
		call mkdir($HOME . '/tmp/vim/swp', 'p')
		call mkdir($HOME . '/tmp/vim/undo')
		call mkdir($HOME . '/tmp/vim/backups')
	endif
	set directory=~/tmp/vim/swp
	set undodir=~/tmp/vim/undo
    set backupdir=~/tmp/vim/backups
	set shell=/bin/zsh
endif
" }}}

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
let g:startify_custom_header = map(split(system('command fortune | cowsay'), '\n'), '"   ". v:val') + ['','']

augroup StartifyHighlightThings
  autocmd! ColorScheme *
        \ hi StartifyBracket ctermfg=241 |
        \ hi StartifyFile    ctermfg=147 |
        \ hi StartifyFooter  ctermfg=240 |
        \ hi StartifyHeader  ctermfg=114 |
        \ hi StartifyNumber  ctermfg=215 |
        \ hi StartifyPath    ctermfg=245 |
        \ hi StartifySlash   ctermfg=240 |
        \ hi StartifySpecial ctermfg=240
augroup END

let g:startify_skiplist = [
    \ 'tmp/',
    \ ]
"
" :
" Status bar experiments
"
" set statusline+=%<\                       " cut at start
" set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
" set statusline+=%-40f\                    " path
" set statusline+=%=%1*%y%*%*\              " file type
" set statusline+=%10((%l,%c)%)\            " line and column
" set statusline+=%P                        " percentage of file
" 
" 
" " jamessan's
" set statusline=   " clear the statusline for when vimrc is reloaded
" set statusline+=%-3.3n\                      " buffer number
" set statusline+=%f\                          " file name
" set statusline+=%h%m%r%w                     " flags
" set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
" set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
" set statusline+=%{&fileformat}]              " file format
" set statusline+=%=                           " right align
" set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
" set statusline+=%b,0x%-8B\                   " current char
" set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset


" tpope's
" set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}\ %y%=%-16(\ %l,%c-%v\ %)\ [%{strftime('%a\ %b\ %e\ %I:%M\ %p')}]\ %P

" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'linterstatus' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead',
"       \   'linterstatus': 'LinterStatus'
"       \ },
"       \ }



let g:airline_powerline_fonts = 1
let g:airline_experimental = 1
let w:airline_skip_empty_sections = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

" let g:airline_section_z='%3p%% %#__accent_bold# %#__accent_yellow# 󰬓%4l/%4t %#__restore__# %3v'
"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.colnr =  ' ⣾ '
let g:airline_symbols.linenr =  ' ⣾ '
let g:airline_symbols.maxlinenr = ' '

" {{{ themeing
set background=dark
" following fix color issue anad redraw issue, do not remove
set t_ut=
if has("gui_running")
	set guioptions=acegit
    colorscheme spaceduck
	" set gfn=Roboto\ Mono\ Medium\ for\ Powerline\ Medium\ 12
	" set gfn=Fantasque\ Sans\ Mono\ Regular\ 12
	set guifont=Martian\ Mono\ 12
    " gui related settings for few issues
    set linespace=2
    set guiheadroom=0
else
	set t_Co=256
	set termguicolors
    " Set color scheme according to current time of day.
    " let hr = str2nr(strftime('%H'))
    " if hr <= 6 || hr > 18
    "     let cs = 'Tomorrow-Night'
    " else
    "     let cs = 'seoul256-light'
    " endif
    " execute 'colorscheme '.cs
    "...
    " let ayucolor="light"  " for light version of theme
    " let ayucolor="mirage" " for mirage version of theme
    " colorscheme everforest
    " colorscheme darkbone
    " colorscheme retrobox

    " colorscheme sidonia
   " let base16colorspace=256
   colorscheme gruvbox
   " colorscheme vimspectr0wcurve-dark
   " colorscheme smyck
   " function! s:base16_customize() abort
   "     call Base16hi("javaOperator", g:base16_gui0B, "", g:base16_cterm0B,"" , "", "")
   " endfunction

   " augroup on_change_colorschema
   " autocmd!
   "     autocmd ColorScheme * call s:base16_customize()
   " augroup END

    "highlight Function cterm=bold
    "highlight Keyword cterm=bold
    "highlight Conditional cterm=bold
    "highlight javaRepeat cterm=bold
endif
" }}}

