"-------------------------------VUNDLE----------------------------------"
"set nocompatible              " be iMproved, required
"filetype off                  " required
"
"set rtp+=~/.vim/bundle/Vundle.vim
"
"call vundle#begin()
"
"" alternatively, pass a path where Vundle should install plugins
"" call vundle#begin('~/some/path/here')
"" vim +PluginInstall +qall
"" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
""Plugin 'scrooloose/syntastic' "uber awesome syntax and errors highlighter
"Plugin 'scrooloose/nerdtree'
"Plugin 'kien/ctrlp.vim'
"Plugin 'jlanzarotta/bufexplorer'
"Plugin 'majutsushi/tagbar'
"Plugin 'valloric/youcompleteme'
""Plugin 'rdnetto/YCM-Generator', { 'branch': 'stable'}
""Plugin 'tarmack/vim-python-ftplugin'
""Plugin 'fatih/vim-go'
""Plugin 'rking/ag.vim'
""Plugin 'tpope/vim-fugitive'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
""""""""""COLORS""""""""""""""""""
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'w0ng/vim-hybrid'
""Plugin 'jeaye/color_coded'
"
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"-------------------------------VUNDLE----------------------------------"

"-----------------------------Plug-VIM-----------------------------------"
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'majutsushi/tagbar'
Plug 'valloric/youcompleteme'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'nfvs/vim-perforce'
"Plu 'tarmack/vim-python-ftplugin'
"Plu 'fatih/vim-go'
"Plu 'rking/ag.vim'
"Plu 'tpope/vim-fugitive'

"""""""""COLORS""""""""""""""""""

"Plugin 'altercation/vim-colors-solarized'
Plug 'w0ng/vim-hybrid'
"Plugin 'jeaye/color_coded'

call plug#end()

"-----------------------------Plug-VIM-----------------------------------"

filetype plugin indent on    " required
syntax on
" where search all inncludes with 'gf'
let &path.="/home/igala/WORK/Perforce/SPEECH,/home/igala/WORK/Perforce/SPEECH/deliveries,/home/igala/WORK/Perforce/SPEECH_products/armv7-meucy17-adt4.9.1-nop-trc-dbg-rtti/gen,/usr/include/c++/4.8"
set tags=./tags,tags,/home/igala/tags/tags

let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Process_File_Always = 1
let Tlist_Ctags_Cmd = 'ctags --extra=-q --c++-kinds=-p' " to disable two tags creation
"generatee -> ctags -L - --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ indexList
"au FileType cpp set tags^=~/tags
"set includeexpr=substitute(v:fname,'\\.','/','g') for java

let g:ag_working_path_mode="r"

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'cr'
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " for cnlp plugin

"Sometimes when using both vim-go and syntastic Vim will start lagging while
"saving and opening files. The following fixes this
"let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"check c++ files with clang
"let g:syntastic_cpp_checkers = ['gcc.vim']
"let g:syntastic_cpp_clang_exec = ['/usr/bin/clang']

"
" YouCompleteMe options
"
let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:Show_diagnostics_ui = 1 "default 1

"will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 0 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 0 "default 0
let g:ycm_path_to_python_interpreter = '' "default ''

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py" "where to search for .ycm_extra_conf.py if not found
let g:ycm_confirm_extra_conf = 1 " confirm to load python file

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-Space>'

let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsListSnippets="<c-d>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsUsePythonVersion=2
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

nnoremap <F12> :YcmForceCompileAndDiagnostics<CR>

"That way, the cursor is on NERDTree if I haven't opened a specific file, but if I did pick a file it starts in the main window.
autocmd VimEnter * if !argc() | NERDTree | endif
silent! nmap <C-n> :NERDTreeToggle<CR>

set exrc
set secure " dangeres command are forbidden
"folding settings use za,zR,zM command
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=3         "this is just what i use
set foldcolumn=0 "  do not show line scroll to fold down the code

set cmdheight=2
set shortmess=a
set mouse=a
set hidden "hide buffer instead of closing them
set termencoding=utf-8
set autoindent " use indentation of previous line
set smartindent " use intelligent indentation for C
set cin " indent in C style
set et " auto replace
set noruler

set wrap
set linebreak " переносить целые слова
set formatoptions=qrn1
nnoremap j gj
nnoremap k gk

set vb " visual bell
set showcmd
set number
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set expandtab " change tab on whitespace
set tabstop=3 " 3 spaces replace tab
set shiftwidth=3
set smarttab

set title         " change the terminal's title
set nobackup
set noswapfile
set winminheight=0
"set noequalalways
"set winheight=9999
set noruler

"au -> autocmd ->autocommand
au Filetype c,h setlocal ts=8, sw=3, sts=3, cino=>5n-3f0-2{2low1st0

au BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', '\s\+$', -1)
au BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', 'if(', -1)
au BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', '', -1)
au BufWinLeave *.* silent mkview
au BufWinEnter *.* silent loadview

"-----------------------------------Colors-----------------------------------------------"
set t_Co=256
set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
"colorscheme ir_black
"syntax enable
"if has('gui_running')
"   set background=light
"else
"   set background=dark
"endif
"colorscheme solarized
autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
"autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/",expand('<cword>'))

set hlsearch "for search ingnore case and highlight
highlight IncSearch ctermbg=NONE ctermfg=119 cterm=NONE
hi Search ctermfg=Yellow ctermbg=NONE cterm=bold,underline

set colorcolumn=120
hi ColorColumn ctermbg=NONE ctermfg=red " at 80 position the symbol is red
"match OverLength /\%>80v.\+/ " highlight as red all from 80 position
"hi ColorColumn ctermbg=238 " just highlight the column
hi FoldColumn term=NONE ctermfg=14 ctermbg=NONE guifg=Cyan guibg=Grey
hi VertSplit ctermbg=grey ctermfg=grey guifg=#81a2be


"set listchars=tab:»\ ,eol:¶,trail:•
"hi GroupA ctermbg=blue ctermfg=NONE guibg=NONE
"hi GroupB ctermbg=gray ctermfg=NONE guibg=NONE
"match GroupA /\s\+$/
"match GroupB /\t/
set listchars=tab:>-,trail:-,extends:#,nbsp:-
set list " turn on highliting of bad writings

"----------------------------------------------------------------------------------"
"set guifont = "Menlo:12"
set backspace=indent,eol,start

set laststatus=2
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline=\
set statusline+=%n:\ " buffer number
set statusline+=%t " filename with full path
set statusline+=%m " modified flag
set statusline+=\ \
set statusline+=%{&paste?'[paste]\ ':''}
set statusline+=%{&fileencoding}
set statusline+=\ \ %Y " type of file
set statusline+=\ %3.3(%c%) " column number
set statusline+=\ \ %3.9(%l/%L%) " line / total lines
set statusline+=\ \ %{FileSize()}

function! FileSize()
   let bytes = getfsize(expand("%:p"))
   if bytes <= 0
      return ""
   endif
   if bytes < 1024
      return bytes . "B"
   else
      return (bytes / 1024) . "K"
   endif
endfunction

"au FileType edc setlocal expandtab shiftwidth=3 tabstop=3 softtabstop=3 syntax=edc

au BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78 " use non text files in vim
au BufReadPost *.doc silent %!antiword "%"
au BufReadPost *.odt silent %!odt2txt "%"
" reread vim configuration after saving
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
"beda budet
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" Easy window navigation
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l
nnoremap <w-left> :vertical resize +5<cr>
nnoremap <w-right> :vertical resize -5<cr>
nnoremap B ^
nnoremap E $
inoremap jj <ESC>

au FocusLost * :wa

nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

nmap <F3> :A<CR>

nnoremap <silent> <F8> :Rgrep<cr>
let Grep_Default_Filelis = '*.cpp *.hpp'
"nnoremap <silent> <F4> :Ag<cr>

nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc>:BufExplorer<cr>
let g:bufExplorerDetailedHelp=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerReverseSort=1


nmap <C-b> :TagbarToggle<CR>

nmap <silent> ,/ :nohlsearch<CR>
cmap w!! w !sudo tee % >/dev/null "for when you forgot to sudo before editing a file

" move between tabs
map <S-left> :tabp<cr>
nmap <S-left> :tabp<cr>
imap <S-left> <esc>:tabp<cr>i
map <S-right> :tabn<cr>
nmap <S-right> :tabn<cr>
imap <S-right> <esc>:tabn<cr>i
" map <C [> : Esc<cr>
