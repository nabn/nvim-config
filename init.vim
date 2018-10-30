" vim:foldmethod=marker:foldlevel=0

let enabled_filetypes = { 'for': ['javascript', 'typescript'] }

" Plugins {{{
    call plug#begin('~/nvim/plugged')

    " UI {{{{
      " Plug 'Lokaltog/vim-monotone'
      Plug 'junegunn/seoul256.vim'
      Plug 'morhetz/gruvbox'
      " Plug 'yuttie/inkstained-vim'

      Plug 'ap/vim-css-color'
      Plug 'itchyny/lightline.vim'
      Plug 'junegunn/goyo.vim',  { 'on': 'Goyo' }
      Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
      Plug 'mhinz/vim-startify'
    " }}}}

    " Languages {{{
      Plug 'w0rp/ale', enabled_filetypes
      Plug 'sheerun/vim-polyglot'
      Plug 'metakirby5/codi.vim', { 'on': 'Codi' } " Quokka

      " Javascript {{{
        Plug 'othree/javascript-libraries-syntax.vim', enabled_filetypes
        Plug 'jelera/vim-javascript-syntax', enabled_filetypes
        Plug 'heavenshell/vim-jsdoc', { 'on': 'JsDoc' }
      " " }}}

      Plug 'HerringtonDarkholme/yats.vim', enabled_filetypes
      Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
      Plug 'Shougo/deoplete.nvim', enabled_filetypes " For async completion
      Plug 'Shougo/denite.nvim', enabled_filetypes " For Denite features

    " }}}

    " Utils {{{
      Plug '/usr/local/bin/fzf'
      Plug 'airblade/vim-gitgutter'
      Plug 'cohama/lexima.vim'                 " autoclose parens
      Plug 'gregsexton/gitv', {'on': ['Gitv']} " gitk extension for vim
      Plug 'junegunn/fzf.vim'
      Plug 'junegunn/vim-easy-align'
      Plug 'mattn/emmet-vim'
      Plug 'tmhedberg/matchit'                 " extended % matching for HTML, LaTeX, and many other languages
      Plug 'tomtom/tcomment_vim'               " file-type sensible comments
      Plug 'tpope/vim-fugitive'
      Plug 'tpope/vim-repeat'
      Plug 'tpope/vim-surround'
      Plug 'https://github.com/Alok/notational-fzf-vim', { 'on': 'NV' }
      Plug 'junegunn/gv.vim', { 'on': 'BCommits' }
      Plug 'jremmen/vim-ripgrep'
    " }}}

    " Extras {{{
      Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak' } " interactive command execution
      Plug 'christoomey/vim-tmux-navigator'
      Plug 'edkolev/tmuxline.vim'
      Plug 'wakatime/vim-wakatime'
    " }}}

    call plug#end()
" }}}

" Set Declarations {{{
        filetype indent on
        filetype plugin indent on

        set t_Co=256
        set t_8b=[48;2;%lu;%lu;%lum
        set t_8f=[38;2;%lu;%lu;%lum
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
        set encoding=utf8

        let g:python_host_prog='/usr/bin/python'
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        set autoread                                      " if file changes outside of vim, redraw buffer
        set colorcolumn=101
        set completeopt+=preview
        set nolazyredraw                                  " fix for redraw bug. use with 'Native fullscreen windows' disabled on iterm
        set mouse=a
        set diffopt+=vertical
        set expandtab
        set foldlevel=1
        set foldmethod=syntax
        set formatoptions+=j                              " delete comment character when joining commented lines
        set gdefault
        set ignorecase
        set laststatus=2                                  " always show the statusline
        set lazyredraw
        set list
        set listchars=tab:>-,trail:~,extends:>,precedes:< " ,space:. " mark all kinds of whitespace
        set noswapfile
        set hidden                                        " enable multiple unsaved buffers to be maintained
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
        set timeoutlen=400                                " careful! don't render NERDTreeToggle unreachable!
        let &t_ZH="\e[3m"
        let &t_ZR="\e[23m"
        highlight Comment cterm=italic
        set tabstop=2
        set undofile
        set wrap

        set rtp+=/usr/local/opt/fzf
        let g:nv_search_paths = ['~/notes']

        syntax enable
" }}}

" Mappings {{{

  let mapleader=','
  nmap 0 ^
  nmap E $

  nnoremap <leader>a :Rg<Space>
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
  nnoremap rr :vertical resize 105<CR>

  " nnoremap <leader><CR> :NERDTreeToggle<CR>
  nnoremap <leader>gs :Gstatus<CR>
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  vmap <CR> <Plug>(LiveEasyAlign)
  " list matches
  nnoremap <leader>lm :vim // %<CR>:copen<CR>
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
  " tnoremap <C-h> <C-\><C-n><C-h>
  " tnoremap <C-j> <C-\><C-n><C-j>
  " tnoremap <C-k> <C-\><C-n><C-k>
  " tnoremap <C-l> <C-\><C-n><C-l>
" }}}

" Easymotion {{{
  " <Leader>f{char} to move to {char}
  map <leader>f <Plug>(easymotion-bd-f)
  nmap <leader>f <Plug>(easymotion-overwin-f)

  map <Leader>L <Plug>(easymotion-bd-jk)
  nmap <Leader>L <Plug>(easymotion-overwin-line)

  " Move to word
  map  <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <Plug>(easymotion-overwin-w)
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
    \   'rg --column --line-number --no-heading --color=always '
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

  autocmd! FileType fzf
  autocmd FileType fzf nmap <C-c> :bw<CR>
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

  function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction

  autocmd! User FzfStatusLine call <SID>fzf_statusline()
" }}}

  " Linters + Formatters {{{
  autocmd FileType html setlocal formatprg=js-beautify\ --type=html\ -A=aligned-multiline
  autocmd FileType xml setlocal formatprg=js-beautify\ --xml\ -A\ force-aligned\ -w\ 100\ --indent-size\ 2
  autocmd FileType less setlocal formatprg=js-beautify\ --css\ -A\ force-aligned\ -w\ 100\ --indent-size\ 2

  " don't lint HTML
  let g:ale_linters = {
        \ 'typescript': ['tslint'],
        \ 'html': [],
        \ 'haskell': [ 'hlint', 'hdevtools', 'hfmt'],
        \ }

  let g:ale_fixers = {
        \ 'javascript': ['prettier'],
        \ 'typescript': ['prettier', 'tslint'],
        \ 'json': ['prettier'],
        \ 'less': ['prettier'],
        \ }

  " use local config
  let g:ale_javascript_prettier_use_local_config = 1

  " primitive html auto-format
  vnoremap <leader>x JV:s/>\s*</>\r</<CR>

  nnoremap <leader>f :ALEFix<CR>

  vnoremap <leader>p :!prettier<CR>
  " }}}

  " Misc {{{
  let g:deoplete#enable_at_startup=1
  let g:startify_change_to_vcs_root=1
  let g:gitgutter_enabled=1
  let g:gitgutter_signs=1
  let g:gitgutter_hightlight_lines=1
  let g:gruvbox_italic=1

  command! Invbg call helpers#ReverseBackground()
  noremap <leader>co :Invbg<CR>

  if has('nvim') " fix for nvim on iterm
    nmap <BS> <C-W>h
  endif

  " let g:tmuxline_preset='tmux'
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '#{?window_zoomed_flag,#[fg=red]} ',
        \'win'  : '#I #W',
        \'cwin' : '#I #W',
        \'y'    : '%a %R',
        \'z'    : '',
        \'x'    : '#(tmux-spotify-info)'}

  let g:tmuxline_powerline_separators = 0
  autocmd filetype make setlocal noexpandtab

  " swap between test and source files
  function! SwapTestFile()
    let fileName = expand('%d')

    if fileName =~ "spec"
      execute "edit " . substitute(fileName, ".spec", "", "")
    else
      execute "edit " . substitute(fileName, ".ts", ".spec.ts", "")
    endif
  endfunction

  nmap tt :call SwapTestFile()<CR>
  " }}}

inoremap <S-Tab> <C-x><C-o>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:used_javascript_libs = 'angularjs'

" 233 darkerst, 239 lightest
let g:seoul256_background = 234
colo gruvbox

" prevent opening 1 when I mean :e!
autocmd BufNew 1 throw 'nope!'

se noshowmode
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

au BufRead *.json set filetype=json5
