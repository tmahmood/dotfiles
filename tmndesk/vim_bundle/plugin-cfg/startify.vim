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
