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
