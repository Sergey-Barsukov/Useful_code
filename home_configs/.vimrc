syntax on
set encoding=utf-8
set number
set tabstop=2
set shiftwidth=2
set wm=5
set wrap
set formatoptions-=t
set nolbr
set expandtab

set backspace=indent,eol,start

" highlite 80 column
set colorcolumn=80
highlight ColorColumn guibg=lightgrey ctermbg=8

set mousehide
set novisualbell
set t_vb=
set nobackup
set noswapfile
set fileencodings=utf8,cp1251
set undodir=~/.vim/undodir
set undofile
set incsearch
set autoindent
set pastetoggle=<F10>

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

call plug#end()

set nocompatible
filetype plugin on

" Space as <leader>
let mapleader=" "

" Debugger remaps
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools' ]
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call win_gotoid(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call win_gotoid(g:vimspector_session_windows.terminal)<CR>
nnoremap <leader>dv :call win_gotoid(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call win_gotoid(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call win_gotoid(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

"let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>dp <Plug>VimspectorPause
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

colorscheme gruvbox
set background=dark

if executable('rg')
	let g:rg_derive_root='true'
endif

let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25
let g:ctrlp_use_caching=0

" Vimwiki
let wiki_1 = {}
let wiki_1.path = '~/Documents/vimwiki/managment'
let g:vimwiki_list = [wiki_1] 

" Vimspector (debug)

" Tabs navigation
nnoremap <C-j> :tabprevious<CR>                                                                            
nnoremap <C-k> :tabnext<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-d> :tabclose<CR>
nnoremap <C-x> :tabo<CR>

" Remaps.
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>

" NERDTree
map <silent> <leader>t :NERDTreeToggle<CR> :NERDTreeMirror<CR>

nnoremap <leader>u :UndotreeShow<CR>

nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
let g:ycm_auto_hover=''
nmap <leader>i <plug>(YCMHover)

let g:ycm_auto_trigger = 0

" goto the reqdWinNum^th window. returns 0 on failure otherwise 1.
function! GotoWindow(reqdWinNum)
	let startWinNum = winnr()
	if startWinNum == a:reqdWinNum
		return 1
	end
	if winbufnr(a:reqdWinNum) == -1
		return 0
	else
		exe a:reqdWinNum.' wincmd w'
		return 1
	end

endfunction

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
