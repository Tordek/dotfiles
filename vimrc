filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

let g:slimv_impl="sbcl"
let g:slimv_client="python /home/tordek/.vim/bundle/slimv/ftplugin/slimv.py -l sbcl"

"disable retarted surround mappings
let g:surround_no_mappings = 1

au BufRead,BufNewFile *.asd set filetype=lisp

syntax on

"leader
let mapleader = "\\"

"\G retabs
nnoremap <leader>G gg=G
"\S sorts CSS
autocmd FileType css nnoremap <leader>S ?{<CR>jV/^\s*\}\?$<CR>k:sort<CR>:noh<CR>
"\w vsplits
nnoremap <leader>w <C-w>v<C-w>l

"Prevent exploits
set modelines=0

"Start with cursor wherever it was last time.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Except for COMMIT_EDITMSG
autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"

filetype plugin on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

"tabs
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab
set inde=
set cindent
set smartindent

"per-filetype tabs
autocmd FileType python set expandtab
autocmd FileType tex set expandtab ts=2 sw=2 sts=2
autocmd FileType lisp set nocindent autoindent lisp

"Show lines as completely as possible
set dy=lastline,uhex

set lbr "Wrap lines

"Save undo history to file. Do not litter.
set undofile
set backupdir=~/.vimbackup,/tmp,.
set undodir=~/.vimbackup,/tmp,.
set directory=~/.vimbackup,/tmp,.

set clipboard=unnamed "Yank into X's clipboard by default

"Show some invisible chars
set list
set listchars=tab:▸\ ,trail:·

set scrolloff=5 "Show 5 lines below cursor

set background=dark
set number
set hidden
set encoding=utf-8
set title "Change terminal title
set shortmess=atI
set history=5000
set ruler

"searching
set ignorecase
set smartcase
set incsearch showmatch hlsearch
nnoremap <leader><space> :noh<cr>

"F1 = ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"; = :
nnoremap ; :

set ttyfast

"menu on :e
set wildmenu
set wildmode=list:longest

"set spell
set spelllang=es

set guioptions=a

"colors
color desert256
set colorcolumn=80

let g:treeExplVertical=1
let g:treeExplWinSize=40

command! Q  quit
command! W  write
command! Wq wq

"Visual navigation instead of physical.
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap <home> g^
nnoremap <end> g$

vnoremap j gj
vnoremap k gk
vnoremap <Down> gj
vnoremap <Up> gk
vnoremap <home> g^
vnoremap <end> g$

inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
inoremap <Home> <C-o>g^
inoremap <end> <C-o>g$

map <F2> :NERDTreeToggle<CR>
map <F3> :set number! list! colorcolumn=0<CR> "Easier copypaste
map H ^
map L $

" Toggle folds with spacebar.
nnoremap <space> za

"markdown title helper
let @h = "yypVr"

cab o find

" buffer navigation (urxvt hack)
"nmap <C-Up> :bn<CR>
"nmap <C-Down> :bp<CR>
nmap <ESC>Oa :bn<CR>
nmap <ESC>Ob :bp<CR>

"Window navigation.
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l
imap <c-w> <c-o><c-w>

map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" Match open/close pairs
inoremap ( ()<Left>
inoremap ) <c-r>=ClosePair(')')<CR>

inoremap [ []<Left>
inoremap ] <c-r>=ClosePair(']')<CR>

inoremap { {}<Left>
inoremap {<CR> {<CR>}<ESC>k$a<CR>
inoremap } <c-r>=ClosePair('}')<CR>

inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

"Exceptions
autocmd Syntax lisp inoremap ' '
"autocmd Syntax vim inoremap \" \"

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<ESC>i"
	endif
endf
