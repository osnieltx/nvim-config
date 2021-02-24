set number relativenumber
set colorcolumn=100

" Enable completion where available.
let g:ale_completion_enabled = 1

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" File navigator
Plug 'https://github.com/justinmk/vim-dirvish'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Status bar
Plug 'vim-airline/vim-airline'
" Git
Plug 'tpope/vim-fugitive'
" Git commit browser
Plug 'junegunn/gv.vim'
" Autocompletion
Plug 'davidhalter/jedi-vim'
" Code inspection
Plug 'dense-analysis/ale'
" Add comentaries
Plug 'tpope/vim-commentary'
" Python text objects
Plug 'jeetsukumaran/vim-pythonsense'
" Fancy start screnn
Plug 'mhinz/vim-startify'
" Changes the working directory to the project root
Plug 'airblade/vim-rooter'
" Provides mappings to easily delete, change and add surroundings
Plug 'tpope/vim-surround'
" Initialize plugin system
call plug#end()

let g:jedi#smart_auto_mappings = 1

let g:ale_python_flake8_options = '--max-line-length=100'
" Fix files with autoimport
let g:ale_fixers = ['autoimport']
" Ale automatic imports from external modules
let g:ale_completion_autoimport = 1

syntax on
colorscheme onedark

nnoremap <silent> gd <Plug>(coc-definition)

" Autocompletes
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Folding
au BufNewFile,BufRead *.py
      \ set foldmethod=indent
set foldlevel=4

" ------ MAPS -------"
" Better way to escape insert mode
inoremap jk <Esc>
" Folding with space
nnoremap <space> za
" Breaking line with return
nnoremap <CR> i<CR><ESC>
" Easier way to navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open folders in tree style
augroup dirvish_config
autocmd!
autocmd FileType dirvish
            \ nnoremap <silent><buffer> t ddO<Esc>:let @"=substitute(@", '\n', '', 'g')<CR>:r ! find "<C-R>"" -maxdepth 1 -print0 \| xargs -0 ls -Fd<CR>:silent! keeppatterns %s/\/\//\//g<CR>:silent! keeppatterns %s/[^a-zA-Z0-9\/]$//g<CR>:silent! keeppatterns g/^$/d<CR>:noh<CR>
augroup END

set ignorecase
set clipboard=unnamed

command! -bang CLF call fzf#vim#files('~/Documents/Linker/Core_Ledger', <bang>0)
nnoremap clf :CLF<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --sort path -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

set mouse=a

" easier way to leeave terminal mode
:tnoremap jk <C-\><C-n>
" dont show line number while on terminal
autocmd TermOpen * setlocal nonumber norelativenumber
