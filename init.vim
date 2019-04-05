" vim:foldmethod=marker:foldlevel=0
" Plugins {{{
  let enabled_filetypes = { 'for': ['javascript', 'typescript', 'html'] }

  call plug#begin('~/nvim/plugged')

" UI {{{{
    Plug 'morhetz/gruvbox'
    Plug 'yuttie/inkstained-vim'
    Plug 'mhartington/oceanic-next'

    Plug 'ap/vim-css-color'
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/goyo.vim',  { 'on': 'Goyo' }
    Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
" }}}}
" Languages {{{
    Plug 'w0rp/ale', enabled_filetypes
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    " Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
    " Plug 'Shougo/deoplete.nvim', enabled_filetypes
" }}}
" Utils {{{
    Plug '/usr/local/bin/fzf'
    Plug 'cohama/lexima.vim'                 " autoclose parens
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'mattn/emmet-vim'
    Plug 'tmhedberg/matchit'                 " extended % matching for HTML, LaTeX, and many other languages
    Plug 'tomtom/tcomment_vim'               " file-type sensible comments
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
" }}}
" Extras {{{
    Plug 'christoomey/vim-tmux-navigator'
" }}}

  call plug#end()
" }}}
" Set Declarations {{{
  filetype indent on
  filetype plugin indent on

  highlight Comment cterm=italic

  let g:nv_search_paths = ['~/notes']
  let g:python_host_prog='/usr/bin/python'
  hi SpellBad  gui=undercurl guisp=red term=undercurl cterm=undercurl

  set shellcmdflag=-ic                              " https://stackoverflow.com/a/4642855/10926788

  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
  set termguicolors
  set encoding=utf8
  set autoread                                      " if file changes outside of vim, redraw buffer
  set completeopt+=preview
  set diffopt+=vertical
  set expandtab
  set foldlevel=1
  set foldmethod=syntax
  set formatoptions+=j                              " delete comment character when joining commented lines
  set gdefault
  set hidden                                        " enable multiple unsaved buffers to be maintained
  set ignorecase
  set laststatus=2                                  " always show the statusline
  set lazyredraw
  set list
  set listchars=tab:>-,trail:~,extends:>,precedes:< " ,space:. " mark all kinds of whitespace
  set mouse=a
  set nolazyredraw                                  " fix for redraw bug. use with 'Native fullscreen windows' disabled on iterm
  set noshowmode
  set noswapfile
  set number
  set relativenumber
  set ruler
  set shiftwidth=2
  set showcmd
  set showmatch
  set signcolumn=yes
  set smartcase
  set smartindent
  set softtabstop=2
  set tabstop=2
  set timeoutlen=400                                " careful! don't render NERDTreeToggle unreachable!
  set undofile
  set wrap
  set rtp+=/usr/local/opt/fzf

  syntax enable
" }}}
" Mappings {{{
  let mapleader=','
  nmap 0 ^
  nmap E $

  let g:rg_highlight='true'
  let g:rg_derive_root='true'

  nnoremap j gj
  nnoremap k gk
  nnoremap <leader>n :nohl<CR>
  nnoremap <space> za                 " toggle folding
  nnoremap z<space> zO                " open all folds under cursor
  nnoremap gV `[v`]                   " highlight last inserted text
  nnoremap <leader>tn :tabnew<CR>
  nnoremap <leader>tc :tabclose<CR>
  nnoremap <leader>t<leader> :tabn<CR>
  nnoremap <leader>z :Goyo<CR>
  nnoremap <leader><space> :b#<CR>    " switch to last buffer
  nnoremap <leader>o :only<CR>
  nnoremap <leader>O :call helpers#DeleteHiddenBuffers()<CR>
  nnoremap <leader>N :NV<CR>

  nnoremap <leader>e :e ~/.config/nvim/init.vim<CR>
  nnoremap <leader>q :bd<CR>
  nnoremap <leader>R :e!<CR>

" nnoremap <leader><CR> :NERDTreeToggle<CR>
  nnoremap <leader>gs :Gstatus<CR>
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  vmap <CR> <Plug>(LiveEasyAlign)
" list matches
  nnoremap <leader>lm :vim // %<CR>:copen<CR>

" visually swap two words
  :vnoremap <C-X> <Esc>`.` `gvP``P
" }}}
" Terminal (neovim) {{{
" Window split settings
  highlight TermCursor ctermfg=red guifg=red
  set splitbelow
  set splitright
" terminal open in split
  command! -nargs=* VT vsplit | terminal <args>
  command! -nargs=* T split | terminal <args>

" Terminal settings
  tnoremap <Leader><ESC> <C-\><C-n>
  tnoremap <ESC> <C-\><C-n>
" }}}
" FZF {{{
  nnoremap <c-b> :Buffers<CR>
  nnoremap <c-f> :Files<CR>

  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
  let g:fzf_buffers_jump = 1
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --pretty --smart-case '
    \ . <q-args>, 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  let g:fzf_commits_log_options = '--format="%C(white)%h%>(15,trunc)%C(blue)%aN%>(15,trunc)%C(yellow)%ar %C(green)%s"'

" make FZF use colorscheme colors
  let g:fzf_colors =
        \ { 'fg':    ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

" }}}
" Linters + Formatters {{{
  autocmd FileType html setlocal formatprg=js-beautify\ --type=html\ -A=aligned-multiline
  autocmd FileType xml setlocal formatprg=js-beautify\ --xml\ -A\ force-aligned\ -w\ 100\ --indent-size\ 2
  autocmd FileType less setlocal formatprg=js-beautify\ --css\ -A\ force-aligned\ -w\ 100\ --indent-size\ 2

" don't lint HTML
  let g:ale_linters = {
        \ 'html': [],
        \ 'javascript': ['eslint'],
        \ 'haskell': [ 'hlint', 'hdevtools', 'hfmt'],
        \ }

  let g:ale_fixers = {
        \ 'javascript': ['prettier'],
        \ 'javascript.jsx': ['prettier'],
        \ 'typescript': ['tslint'],
        \ 'json': ['prettier'],
        \ 'less': ['prettier'],
        \ 'html': ['prettier'],
        \ '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ }

  let g:ale_pattern_options = {
        \ 'node_modules/': { 'ale_enabled': 0 }
        \ }

" use local config
  let g:ale_javascript_prettier_use_local_config = 1

" open the quickfix list instead of just displaying one line
" let g:ale_open_list = 1

  let g:ale_list_window_size = 10
  let g:ale_keep_list_window_open = 1

  nnoremap ep :ALEPrevious<CR>
  nnoremap en :ALENext<CR>
  nnoremap ed :ALEDetail<CR>
  nnoremap eh :ALEHover<CR>

" primitive html auto-format
  vnoremap <leader>x JV:s/>\s*</>\r</<CR>

" nnoremap <leader>f :!npx tslint --fix<CR>
  nnoremap <leader>f :ALEFix<CR>
" nnoremap <leader>p :%!prettier --single-quote --trailing-comma es5  %<CR>
  nnoremap <leader>p :silent exec '%!prettier --single-quote --trailing-comma=all --parser='. &filetype<CR>
" }}}
" Misc {{{
  let g:deoplete#enable_at_startup=1
  let g:startify_change_to_vcs_root=1
  let g:gitgutter_enabled=1
  let g:gitgutter_signs=1
  let g:gitgutter_hightlight_lines=1
  let g:gruvbox_italic=1

  let g:goyo_width=120
  let g:goyo_linenr=1

  command! Invbg call helpers#ReverseBackground()
  noremap <leader>co :Invbg<CR>

  if has('nvim')                                    " fix for nvim on iterm
    nmap <BS> <C-W>h
  endif

" let g:tmuxline_preset='tmux'
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '#{?window_zoomed_flag,#[fg=red]} ',
        \'win'  : '#I #W',
        \'cwin' : '#I #W',
        \'y'    : '%a %R',
        \'z'    : '',}
" \'x'    : '#(tmux-spotify-info)'}

  let g:tmuxline_powerline_separators = 0

  nmap tt :call helpers#SwapTestFile()<CR>

  inoremap <S-Tab> <C-x><C-o>
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  let g:used_javascript_libs = 'angularjs'

" prevent opening 1 when I mean :e!
  autocmd BufNew 1 throw 'You ment to :e! but did :e1'

" \ 'colorscheme': 'seoul256',
" \ 'colorscheme': 'inkstained',
  let g:lightline = {
        \ 'active': {
        \   'left': [[ 'mode', 'paste' ],
        \            [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'fugitive#head'
        \ },
        \ }

" \ 'separator':    { 'left': '', 'right': '' },
" \ 'subseparator': { 'left': '', 'right': '' },

" 233 darkerst, 239 lightest
  let g:seoul256_background=234
  let g:gruvbox_bold=0
  colo OceanicNext
" se bg=dark

  nmap <c-n> <plug>(YoinkPostPasteSwapBack)
  nmap <c-p> <plug>(YoinkPostPasteSwapForward)

" fix the cursor color
  if &term =~ "xterm\\|rxvt"
" use an orange cursor in insert mode
    let &t_SI = "\<Esc>]12;orange\x7"
" use a red cursor otherwise
    let &t_EI = "\<Esc>]12;red\x7"
    silent !echo -ne "\033]12;red\007"
" reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\033]112\007"
" use \003]12;gray\007 for gnome-terminal
  endif


" sort imports alphabetically
  function! SortImports()
    let imprts = getline('.')
    echo 'GOT' . imprts
  endfunction
  :command! SortImports :call SortImports()
  :nnoremap <c-n> :call :SortImports<cr>

  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m
" }}}

" CoC {{{
  inoremap <silent><expr> <c-space> coc#refresh()
  set cmdheight=2
  set updatetime=300
  set shortmess+=c
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  command! -nargs=0 Format :call CocAction('format')
  let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste','gitbranch'],
      \             [ 'cocstatus', 'readonly', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'helpers#GetTicketNumber'
      \ },
      \ }

  inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
  let g:coc_snippet_next = '<TAB>'
  let g:coc_snippet_prev = '<S-TAB>'
"}}}
