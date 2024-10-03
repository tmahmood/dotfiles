
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

