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
