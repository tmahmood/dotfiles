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
