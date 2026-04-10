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
