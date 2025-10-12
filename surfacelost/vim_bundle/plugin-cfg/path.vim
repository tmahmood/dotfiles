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

