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
