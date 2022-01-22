set nocompatible              " be iMproved, required
filetype off                  " required

" Note that the plugin file location might be different. You might want to recheck it manually.
call plug#begin("~/.config/nvim/plugged")
" Plugin Section
"--------------------------------------------
Plug 'joshdick/onedark.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'rking/ag.vim' "brew install ag
Plug 'mattn/emmet-vim'
Plug 'vifm/vifm.vim' "brew install vifm
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'zivyangll/git-blame.vim'

"--------------------------------------------
call plug#end()
" Everything after this line will be the config section

"============= onedark color theme  =============
syntax on                   "Use syntax highlighting
colorscheme onedark            

"============= Settings =============
set number                      "Line numbers
"set colorcolumn=80              "Have a line after 80 char
set ruler                       "Add ruler at the bottom of vim
set cursorline
set cursorcolumn
set wildmenu
set incsearch
set relativenumber
set laststatus=2
set encoding=UTF-8
"set updatetime=250
set mouse=a
set tabstop=4
set shiftwidth=4
set wildcharm=<Tab>
highlight Pmenu ctermbg=238
set fillchars+=vert:│
hi VertSplit ctermbg=white

" loading the plugin
let g:webdevicons_enable = 1
" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 1

let g:ctrlp_by_filename = 1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"Cursor settings:
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

"Mode Settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"fix delay when change modes 
"set timeoutlen=1000 ttimeoutlen=10
set nofixeol

" ALE (Asynchronous Lint Engine)
"let g:ale_fixers = {
" \ 'javascript': ['eslint']
" \ }
"let g:ale_sign_error = '❌'
"let g:ale_sign_warning = '⚠️'
"let g:ale_fix_on_save = 1

" COC
" " COC extension
let g:coc_user_config = {}
let g:coc_global_extensions = [
      \ 'coc-emmet', 
      \ 'coc-css', 
      \ 'coc-html', 
      \ 'coc-json', 
      \ 'coc-prettier', 
      \ 'coc-tsserver', 
      \ 'coc-snippets', 
      \ 'coc-eslint']
" " To go back to previous state use Ctrl+O
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" " Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh() 

" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" " Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected

augroup mygroup
  autocmd!
  " " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" " Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" set undotree file directory
set undodir=~/.config/nvim/undodir 
" set undotree to save to file
set undofile 

lua require('config')

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>e :Vifm<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>bb :b#<CR>
nnoremap <leader>bl :ls<CR>
nnoremap <leader>. :bnext<CR>
nnoremap <leader>, :bprevious<CR>
nnoremap <leader>c :e %:h<Tab>
nnoremap <leader>r :e<CR>
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>
