set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('init')
lua require('plugins')

lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}
lua require('mason').setup()

"colorscheme nightfox
colorscheme gruvbox

if exists("g:neovide")
  "let g:neovide_cursor_animation_length = 0
  set clipboard=unnamed
  set guifont=Source\ Code\ Pro\ 11
endif

set clipboard+=unnamedplus

" terminal
nmap <leader>t :vnew term://zsh <CR> :wincmd L<CR>i
tnoremap <Tab> <C-\><C-n><C-w>h
nnoremap <Tab> <C-w>li
autocmd TermOpen * set nonumber
