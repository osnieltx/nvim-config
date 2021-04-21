set number relativenumber
set colorcolumn=119
highlight ColorColumn ctermbg=236

" Specify a directory for plugins
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
" Plug 'davidhalter/jedi-vim'
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
" Cheat shet
Plug 'dbeniamine/cheat.sh-vim'
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Initialize plugin system
call plug#end()

" automatically add the \"import" statement
let g:jedi#smart_auto_mappings = 1
let g:jedi#documentation_command = ''

let g:ale_python_flake8_options = '--max-line-length=119'
" Fix files with autoimport
let g:ale_fixers = ['autoimport']
" Ale automatic imports from external modules
let g:ale_completion_autoimport = 1
" Enable completion where available.
let g:ale_completion_enabled = 1

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

" ------ COC -------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on ener, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gu <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" ------ MAPS -------
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
" Fuzzy finder
nnoremap fz :FZF<CR>
" Rg
nnoremap gr :Rg<CR>

" open folders in tree style
augroup dirvish_config
autocmd!
autocmd FileType dirvish
            \ nnoremap <silent><buffer> t ddO<Esc>:let @"=substitute(@", '\n', '', 'g')<CR>:r ! find "<C-R>"" -maxdepth 1 -print0 \| xargs -0 ls -Fd<CR>:silent! keeppatterns %s/\/\//\//g<CR>:silent! keeppatterns %s/[^a-zA-Z0-9\/]$//g<CR>:silent! keeppatterns g/^$/d<CR>:noh<CR>
augroup END

" Configs made with nvim options
set ignorecase
set mouse=a
set clipboard=unnamed
set splitbelow
set splitright

command! -bang CLF call fzf#vim#files('~/Documents/Linker/Core_Ledger', <bang>0)
nnoremap clf :CLF<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --sort path -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)


" easier way to leeave terminal mode
:tnoremap jk <C-\><C-n>
" dont show line number while on terminal
augroup custom_term
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup END

" Change to directory using fzf and dirvish
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'find /Users/osniellopesteixeira/Documents/'.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'Dirvish'}))
