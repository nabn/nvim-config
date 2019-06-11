let g:nvim_typescript#default_mappings=1
let g:nvim_typescript#signature_complete=1

setlocal keywordprg=:ALEHover
" setlocal colorcolumn=101

nnoremap rr :vertical resize 107<CR>
" nnoremap gd :TSDef<CR>

nnoremap gp :silent %!prettier --stdin --stdin-filepath % --parser=typescript --semi=false --single-quote --trailing-comma=all<CR>
