set nocp


"Allow C-S/C-Q mapping
silent !stty -ixon > /dev/null 2>/dev/null

filetype off

filetype plugin indent on

syntax on
set mouse=a
set number
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set bs=2
set splitright
set splitbelow
"set nowrap

"Ctrl-V with system buffer
"imap <C-v> <C-O>:set paste<cr><C-R><C-O>:set nopaste<cr>

"Folding -> zo zc zO zC za zA zR zM
set foldmethod=syntax

" run make
map <F9> :make<CR>
inoremap <F9> <ESC>:make<CR>
vnoremap <F9> <ESC>:make<CR>

" save all and make
noremap <F10> :wa<CR>:make<CR>
inoremap <F10> <ESC>:wa<CR>:make<CR>
vnoremap <F10> <ESC>:wa<CR>:make<CR>

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
noremap <silent> <C-S> :Update<CR>
" Save with Ctrl+S, also in insert and visual mode
inoremap <C-S> <C-O>:Update<CR>
vnoremap <C-S> <C-C>:Update<CR>gv
" Close buffer with Ctrl+q
noremap <silent> <C-Q> <Esc>:q<CR>
inoremap <silent> <C-Q> <Esc>:q<CR>
vnoremap <silent> <C-Q> <Esc>:q<CR>


" Relative line number
function! NumberToggle()
	if(&relativenumber == 1)
		set nornu
	else
		set rnu
	endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
:au FocusLost * :set nornu |redraw!
:au FocusGained * :set rnu | redraw!
autocmd InsertEnter * :set nornu
autocmd InsertLeave * :set rnu | redraw!
set rnu
