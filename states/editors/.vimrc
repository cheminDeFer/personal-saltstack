" for skipping system setting
let skip_defaults_vim=1
set nocompatible
"########### Vi compatible? ############
" automatically indent new lines
set autoindent

" automatically write files when changing multiple files open
set autowrite

" activate line numbers
set nonumber

" turn col and row position in right bottom
set ruler

" show command and insert mode
set showmode

set tabstop=2

"#######################################################################

set softtabstop=2
set shiftwidth=2
set smartindent
set smarttab

" stop vim from silently fucking with files that it shouldn't
set nofixendofline

" replace tabs with spaces automatically
set expandtab

" enough for line numbers + gutter within 80 standard
set textwidth=72

" disable relative line numbers, remove no to sample it
set norelativenumber

" easier to see characters when `set paste` is on
set listchars=tab:→\ ,eol:↲,nbsp:␣,space:·,trail:·,extends:⟩,precedes:⟨
highlight NonText guifg=bg

" turn on default spell checking
"set spell

" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup

set icon

" center the cursor always on the screen
"set scrolloff=999

" highlight search hits,  \+<cr> to clear
set hlsearch
set incsearch
set linebreak
map <silent> <leader><cr> :noh<cr>:redraw!<cr>

" avoid most of the 'Hit Enter ...' messages
set shortmess=aoOtIF

set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo
"           | |    |   |   |    | |  + viminfo file path
"           | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"           | |    |   |   |    + disable 'hlsearch' loading viminfo
"           | |    |   |   + command-line history saved
"           | |    |   + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list


" not a fan of bracket matching or folding
let g:loaded_matchparen=1
set noshowmatch
set foldmethod=manual

" Just the defaults, these are changed per filetype by plugins.
" Most of the utility of all of this has been superceded by the use of
" modern simplified pandoc for capturing knowledge source instead of
" arbitrary raw text files.

set formatoptions-=t   " don't auto-wrap text using text width
set formatoptions+=c   " autowrap comments using textwidth with leader
set formatoptions-=r   " don't auto-insert comment leader on enter in insert
set formatoptions-=o   " don't auto-insert comment leader on o/O in normal
set formatoptions+=q   " allow formatting of comments with gq
set formatoptions-=w   " don't use trailing whitespace for paragraphs
set formatoptions-=a   " disable auto-formatting of paragraph changes
set formatoptions-=n   " don't recognized numbered lists
set formatoptions+=j   " delete comment prefix when joining
set formatoptions-=2   " don't use the indent of second paragraph line
set formatoptions-=v   " don't use broken 'vi-compatible auto-wrapping'
set formatoptions-=b   " don't use broken 'vi-compatible auto-wrapping'
set formatoptions+=l   " long lines not broken in insert mode
set formatoptions+=m   " multi-byte character line break support
set formatoptions+=M   " don't add space before or after multi-byte char
set formatoptions-=B   " don't add space between two multi-byte chars in join
set formatoptions+=1   " don't break a line after a one-letter word

" stop complaints about switching buffer with changes
set hidden

" command history
set history=100

" here because plugins and stuff need it
syntax enable

" faster scrolling
set ttyfast

" allow sensing the filetype
filetype plugin on

" Install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  echo "Don't forget to GoInstallBinaries if you're doing Go dev."
endif

" high contrast for streaming, etc.
set background=dark

colorscheme pablo

" only load plugins if Plug detected
if filereadable(expand("~/.vim/autoload/plug.vim"))

  " load all the plugins
  call plug#begin('~/.vimplugins')
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  call plug#end()



  "autocmd!

  hi Normal ctermbg=NONE " for transparent background
  hi SpellBad ctermbg=red " for transparent background
  hi SpellRare ctermbg=red
  hi Special ctermfg=cyan

  set noruler
  "set rulerformat=%55(%f\ %y%r\ %l:%c\ %p%%%) "55 effective max

  set laststatus=2
  set statusline=
  set statusline+=%*\ %<%.60F%*                      " path, trunc to 80 length
  set statusline+=\ [%{strlen(&ft)?&ft:'none'}]     " filetype
  set statusline+=%*\ %l:%c%*                        " current line and column
  set statusline+=%*\ %p%%%*                         " percentage

  set cmdheight=1


  " golang
  let g:go_fmt_fail_silently = 0
  let g:go_fmt_command = 'goimports'
  let g:go_fmt_autosave = 1
  let g:go_gopls_enabled = 1
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_variable_declarations = 1
  let g:go_highlight_variable_assignments = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_diagnostic_errors = 1
  let g:go_highlight_diagnostic_warnings = 1
  let g:go_auto_type_info = 1
  let g:go_auto_sameids = 0
  set updatetime=100
  au FileType go nmap <leader>t :GoTest!<CR>
  au FileType go nmap <leader>v :GoVet!<CR>
  au FileType go nmap <leader>b :GoBuild!<CR>
  au FileType go nmap <leader>c :GoCoverageToggle<CR>
  au FileType go nmap <leader>i :GoInfo<CR>
  au FileType go nmap <leader>l :GoMetaLinter!<CR>

else
  autocmd vimleavepre *.go !gofmt -w % " backup if fatih fails
endif

" make Y consitent with D and C (yank til end)
map Y y$

" better command-line completion
set wildmenu

" disable search highlighting with <C-L> when refreshing screen
nnoremap <C-L> :nohl<CR><C-L>

" enable omni-completion
set omnifunc=syntaxcomplete#Complete

" force some file names to be specific file type
au bufnewfile,bufRead *.bash* set ft=sh
au bufnewfile,bufRead *.profile set filetype=sh
au bufnewfile,bufRead *ssh/config set filetype=sshconfig
au bufnewfile,bufRead *gitconfig set filetype=gitconfig
au bufnewfile,bufRead /tmp/psql.edit.* set syntax=sql
au bufnewfile,bufRead doc.go set spell

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" functions keys
map <F1> :set number!<CR> :set relativenumber!<CR>
nmap <F2> :call <SID>SynStack()<CR>
set pastetoggle=<F3>
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F7> :set spell!<CR>
map <F12> :set fdm=indent<CR>

nmap <leader>2 :set paste<CR>i
" Map alternatives the <ESC> key (<C-[> already is)
inoremap jj <Esc>
cnoremap jj <Esc>
inoremap kk <Esc>
cnoremap kk <Esc>
inoremap kj <Esc>
cnoremap kj <Esc>

" read personal/private vim configuration (keep last to override)
set rtp^=~/.vimpersonal
set rtp^=~/.vimprivate

hi StatusLineNC term=none cterm=none gui=none
hi StatusLine term=reverse ctermfg=LightGray cterm=nocombine
