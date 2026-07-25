" ========================
" Plugins Configuration
" ========================

call plug#begin()
  Plug 'rebelot/kanagawa.nvim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'sheerun/vim-polyglot'
  Plug 'neoclide/coc.nvim', { 'branch' : 'release' }
  Plug 'honza/vim-snippets'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'aklt/plantuml-syntax'
  Plug 'weirongxu/plantuml-previewer.vim'
  Plug 'tyru/open-browser.vim'

  if (has("nvim"))
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
  endif
  Plug 'ryanoasis/vim-devicons'
call plug#end()


" ========================
" General Settings
" ========================
syntax on
set textwidth=80
set formatoptions+=t
set linebreak
set nu
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set hidden
set incsearch
set ignorecase
set smartcase
set scrolloff=8
set signcolumn=yes
set cmdheight=2
set encoding=utf-8
set nobackup
set nowritebackup
set splitright
set splitbelow
set autoread
set mouse=a
filetype plugin indent on
set cursorline
set termguicolors
set completeopt=menuone,noinsert,noselect
set updatetime=250
set clipboard+=unnamedplus

" ========================
" Colors and Themes
" ========================
" Nome correto do tema para a Airline
let g:airline_theme = 'dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Executa a configuração Lua do Kanagawa
lua require('kanagawa-config')


" ========================
" Extensões do coc
" ========================
let g:coc_global_extensions = ['coc-snippets', 'coc-explorer', 'coc-pairs']


" ========================
" Auto CMD
" ========================
autocmd VimEnter * silent! CocCommand explorer ~/Documentos/Programas

function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction

autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

" ========================
" Key Mappings
" ========================
" Leader key
let mapleader = " "

" Navegação entre janelas
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Geral commands
nnoremap <leader>r :restart<CR>
nnoremap <leader>i :PlugInstall<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-q> :wq<CR>
nnoremap <C-x> :bd<CR>
nnoremap <C-z> u
nnoremap <C-r> <C-r>
nnoremap <silent> <leader>d :<C-u>call DuplicateLine(v:count1)<CR>
inoremap <C-r> <C-r>
inoremap <C-t> <TAB>

" Comandos adicionais
nnoremap <leader>el :CocList explPresets
nnoremap oo A<CR>
nnoremap <leader>nn :tabe<CR>

" Splits
nnoremap th :split<CR>
nnoremap tv :vsplit<CR>
nnoremap tt :q<CR>

" Explorer Toggle (Substituído NERDTree pelo Coc Explorer, já que você usa CoC)
nnoremap <C-e> :CocCommand explorer<CR>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>


" ========================
" Nvim telescope
" ========================
if (has("nvim"))
    nnoremap <leader>ff :Telescope find_files<CR>
    nnoremap <leader>fg :Telescope git_files<CR>
    nnoremap <leader>fb :Telescope buffers<CR>
    nnoremap <leader>fl :Telescope current_buffer_fuzzy_find<CR>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
endif

" ========================
" Functions
" ========================
" Check if backspace key was pressed
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! DuplicateLine(count)
    let l:line = getline('.')
    call append(line('.'), repeat([l:line], a:count))
endfunction


" Configurações do CoC.nvim
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" ========================
" Coc keymaps
" ========================
nnoremap gd <Plug>(coc-definition)
nnoremap gy <Plug>(coc-type-definition)
nnoremap gi <Plug>(coc-implementation)
nnoremap gr <Plug>(coc-references)
nnoremap K :call CocActionAsync('doHover')<CR>
nnoremap <leader>rn <Plug>(coc-rename)
nnoremap <leader>f :call CocAction('format')<CR>

" ========================
" Coc Snippets
" ========================
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-k> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ s:check_back_space() ? "\<TAB>" :
      \ coc#refresh()
