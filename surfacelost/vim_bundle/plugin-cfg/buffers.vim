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

