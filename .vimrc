syntax on
let mapleader=","
set number
set expandtab
set shiftwidth=4
set tabstop=4
set showmatch 
set smartcase
set ignorecase
set grepprg=ack
set nowrap
set wildmenu
set so=999
set term=screen-256color
set hlsearch
set ruler
set clipboard=unnamedplus

" Keymaps
" -------

" escape
inoremap jj <Esc>

" stay in visual mode after tabbing
vnoremap < <gv
vnoremap > >gv

" Always need checkmarks
inoremap <leader>c ✔

" Insert current human date
nmap <leader>d "=strftime("%b %d, %Y")<CR>P

" The following supports automatically entering paste mode if you use the
" system clipboard paste

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/Align'
Plug 'scrooloose/nerdtree'
Plug 'joonty/vdebug.git'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'miniatureape/quickpr'
Plug 'evanleck/vim-svelte'
call plug#end()

" CtrlP
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_mruf_max = 1000

" VDebug
let g:vdebug_options = {
\    "port" : 9000,
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 0,
\    "ide_key" : '',
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'expanded'
\}

let s:vdebug_host = system("ifconfig | grep inet | grep -v inet6 | awk '{print $2}' | grep -v 127.0.0.1 | head -n 1")
let s:vdebug_host = substitute(s:vdebug_host, '[\n\s\r]*$', '', '')
if !empty(s:vdebug_host)
    let g:vdebug_options['server'] = s:vdebug_host
endif

let g:vdebug_keymap = {
\    "step_over"            : "<Leader><F2>",
\    "step_into"            : "<leader><F3>",
\    "step_out"             : "<leader><F4>",
\    "run"                  : "<Leader><F5>",
\    "close"                : "<Leader><F6>",
\    "detach"               : "<Leader><F7>",
\    "run_to_cursor"        : "<Leader><F8>",
\    "set_breakpoint"       : "<Leader><F10>",
\    "get_context"          : "<Leader><F11>",
\    "eval_under_cursor"    : "<Leader><F12>",
\}
 
let g:vdebug_options = {
\    'marker_default'       : '*',
\    'marker_closed_tree'   : '+',
\    'marker_open_tree'     : '-',
\}

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Vimwiki
let g:vimwiki_list = [ {'path': '~/projects/notes/wiki/', 'path_html': '~/wiki-html/', 'syntax': 'markdown', 'ext': '.md'}]
