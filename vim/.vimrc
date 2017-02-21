" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set backupdir=~/.vim-backup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" search options
set ignorecase
set smartcase
set incsearch		" do incremental searching

set number

set noeol

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" spaces & tabs policy
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" clipboard
set clipboard=unnamed
" delete without copying into clipboard (copies it to _ "black hole" register)
nnoremap R "_d

" plugins
" Pathogen
execute pathogen#infect()

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'JulesWang/css.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'rust-lang/rust.vim'

Plugin 'tpope/vim-rails' 

Plugin 'SirVer/ultisnips'
Plugin 'isRuslan/vim-es6'

call vundle#end()
filetype plugin indent on
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" search within files
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>
nnoremap <Leader>g :vimgrep /
" hide search highlighting
map <Leader>h :set invhls <CR>

" show tab number for easy switching between tabs
set showtabline=2 " always show tabs in gvim, but not vim

" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
	if getbufvar(bufnr, "&modified")
	  let label = '+'
	  break
	endif
  endfor

  " Append the tab number
  let label .= v:lnum.':'

  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
	" give a name to no-name documents
	if &buftype=='quickfix'
	  let name = '[Quickfix List]'
	else
	  let name = '[No Name]'
	endif
  else
	" get only the file name
	let name = fnamemodify(name,":t")
  endif
  let label .= name

  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  "return label . '  [' . wincount . ']'
  return label
endfunction

set guitablabel=%{GuiTabLabel()}

" custom commands
" launch cucumber test for current line
function! LaunchCucumberTest()
  let currentLine = line(".")
  execute "normal! :!cucumber \%:" . currentLine . "\<CR>"
endfunction
nnoremap <Leader>c :call LaunchCucumberTest()<CR>

set shell=/bin/sh " for rvm to work in vim

" syntax-related
au BufRead,BufNewFile *.rabl setf ruby

" ********************  plugins-related configuration ******************** 
"
" FuzzyFinder
nmap ff :FufFile **/
" UtilSnippets
let g:UltiSnipsExpandTrigger="<tab>"

" save file with root privileges
cmap w!! %!sudo tee > /dev/null %

" autocommand to autoreload edited vimrc 
au! BufWritePost _vimrc source %
