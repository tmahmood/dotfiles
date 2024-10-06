if file_readable('.quicksave')
	exec ":so .quicksave"
endif

set nocompatible

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()


set go=acegit


" paths {
if $APPDATA != ''
	let rootpath=$APPDATA . "/vim"
	let undopath=rootpath . "/undo"
	let swappath=rootpath . "/swap"

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
	endif

	let f=fnameescape(swappath)
	exec "set directory=".f

	let f=fnameescape(undopath)
	exec "set undodir=".f

else
	if !isdirectory($HOME . '/tmp/vim')
		call mkdir($HOME . '/tmp/vim/swp', 'p')
		call mkdir($HOME . '/tmp/vim/undo')
	endif
	set directory=~/tmp/vim/swp
	set undodir=~/tmp/vim/undo
	set shell=/bin/bash
endif
" }

" COMMON SETTINGS {
syn on
filetype plugin on

let mapleader="\<space>"

set nobk
set gdefault
set backspace=indent,eol,start
set nu
set hidden
set lazyredraw
set wildmenu
set wildmode=longest:list,full
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*$py.class,*.class
set showbreak=>>>
set showcmd
set cot+=menuone
set numberwidth=4
set encoding=utf-8
set termencoding=utf-8
set undofile
set scrolloff=3
"set cursorline
set switchbuf=useopen
"set number
set rnu

set si
set ai


runtime $VIMRUNTIME/macros/matchit.vim

set ttyfast                     " smoother scrolling
set shm+=I                      " no startup message
set mat=1                       " how many 10ths of a second to blink matching brackets

set wrap
set textwidth=79
set formatoptions=qrn1
set laststatus=2
" }

" SEARCH {
set smartcase
set ignorecase
set incsearch
set hlsearch
set ttimeoutlen=50
" }
" AUTO COMMANDS {
set ts=4
set sw=4
set softtabstop=0
set noexpandtab
autocmd FileType html set spell
autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType phtml set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType sql set omnifunc=sqlcomplete#Complete

" GUI {
"

"set background=dark
if has("gui_running")
	"colorscheme gruvbox
	colorscheme Tomorrow-Night
	set gfn=Source\ Code\ Pro\ 12
else
	if  &term == "linux"
		colorscheme default
	else
		set t_Co=256
		set background=dark

		hi clear
		if exists("syntax_on")
		  syntax reset
		endif
		"colorscheme darkspectrum
		"colorscheme rootwater
		"colorscheme darknight256
		"colorscheme jellybeans
		"colorscheme distinguished
		"colorscheme molokai
		"colorscheme flatcolor
		"colorscheme seoul256
		"colorscheme herald
		"colorscheme slate
		"colorscheme luna-term
		"colorscheme Putty
		"colorscheme wombat256
		"colorscheme badwolf
		"colorscheme darkburn
		"colorscheme xoria256
		"colorscheme smyck
		"colorscheme Tomorrow-Night
		"colorscheme rdark
		"colorscheme twilight
		colorscheme hybrid
	endif
endif
" }
" end
" gui opts no menu and toolbars
" }
"
"
" FUNCTIONS {
"


if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif
" }
"
" FOLDING {{
set foldenable " Turn on folding
set foldmethod=syntax " Fold on the marker


" KEYBOARD MAPPINGS {
"
" show/hide trailling spaces
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


nnoremap <silent><leader>, :split<CR>
nnoremap <silent><leader>. :vsplit<CR>

"
" configuration file
map ,e :source ~/.vimrc<CR>

" Quickfix navigation
nmap cn :cnext<cr>
nmap cp :cprev<cr>

nmap bn <esc>:bn<cr>
nmap bp <esc>:bp<cr>

" Redraw screen and remove search highlights
nnoremap <silent> <cr> :nohl<cr><c-l>


" Start search with word under cursor
nmap ,z :%s/\<<c-r><c-w>\>/
vmap ,z :<c-u>%s/\<<c-r>*\>/

map <Leader>m :marks<cr>

map ,w <esc>:w<cr>



" Fuzzy finder
map ,f <esc>:FufFile<cr>
map ,cf <esc>:FufCoverageFile<cr>
map ,d <esc>:FufDir<cr>
map ,g <esc>:FufBuffer<CR>
map ,k <esc>:FufTagWithCursorWord<cr>
map ,j <esc>:FufJumpList<cr>
map ,c <esc>:FufChangeList<cr>
map ,l <esc>:FufLine<cr>
map ,b <esc>:FufBufferTag<cr>
map ,ft <esc>:FufTag<cr>

nnoremap <leader>t :CtrlPBufTag<CR>

map \r <esc>:reg<cr>

map ,u <esc>:GundoToggle<cr>

map ,bd <esc>:bd<cr>

"Pressing ,ss will toggle and untoggle spell checking
map ,ss :setlocal spell!<cr>

map \c <esc>:Git commit<cr>
map \g <esc>:Gitv<cr>

" Yep ... no more up keys
map <UP> <esc>
map <DOWN> <esc>
map <LEFT> <esc>
map <RIGHT> <esc>

"}
" PLUGIN SETTINGS {

"let MRU_Max_Entries = 1000


map \\wk <esc>:VimWiki<cr>
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]

" }
" Whitespaces {
" Highlight unwanted spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Show trailing whitespace
match ExtraWhitespace /\s\+$/

" Show trailing whitepace and spaces before a tab
"match ExtraWhitespace /\s\+$\| \+\ze\t/
"
"" Show tabs that are not at the start of a line
"match ExtraWhitespace /[^\t]\zs\t\+/

" Show spaces used for indenting (so you use only tabs for indenting)
match ExtraWhitespace /^\t*\zs \+/

" }
"" Bring back old cursor position {
autocmd BufReadPost *
	  \ if ! exists("g:leave_my_cursor_position_alone") |
	  \     if line("'\"") > 0 && line ("'\"") <= line("$") |
	  \         exe "normal g'\"" |
	  \     endif |
	  \ endif
"}
"}
"
"

let g:NumberToggleTrigger="<F2>"


let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]

" show marks
"


let g:showmarks_enable=1
let g:showmarks_textlower = "\t "
let g:showmarks_textupper = "\t "
let g:showmarks_textother = "\t "

highlight ShowMarksHLl ctermbg=0 ctermfg=white guifg=red guibg=green
highlight ShowMarksHLu ctermbg=0 ctermfg=white guifg=red guibg=green
highlight ShowMarksHLo ctermbg=0 ctermfg=white guifg=red guibg=green
highlight ShowMarksHLm ctermbg=0 ctermfg=white guifg=red guibg=green

hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment


let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0

if has("gui_running")
	hi IndentGuidesOdd  guibg=#2d2d2d
	hi IndentGuidesEven guibg=black
else
	hi IndentGuidesOdd  ctermbg=233
	hi IndentGuidesEven ctermbg=232
endif


" update tag file/headless make/display errors
map <Leader>h :Dispatch! ctags -R --fields=+iaS --extra=+q .<CR>
map <Leader>d :Make!<cr>
map <Leader>c :copen<cr>
map <Leader>e :Errors<cr>
map <Leader>k :make<cr>

autocmd BufWritePre * :%s/\s\+$//e


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

fun QuickExit()
	exec ':mksession'
	exec ':xa'
endf
map <Leader>q :call QuickExit()<cr>

map <leader>kc :e application/classes/Controller/
map <leader>km :e application/classes/Model/
map <leader>kv :e application/classes/View/
map <leader>kt :e application/templates

let g:ctrlp_open_new_file = 'h'

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
