set nocompatible   " Disable vi-compatibility

colorscheme evening

command! -bang Q quit<bang>
command! -bang W write<bang>
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
set guifont=Iosevka\ Nerd\ Font\ Propo:h8
set conceallevel=0
nnoremap <expr> <C-d> (winheight(0) / 3) . '<C-d>'
nnoremap <expr> <C-u> (winheight(0) / 3) . '<C-u>'
inoremap jk <Esc>
inoremap jj <Esc>

inoremap ;wq <C-o><cmd>wq!<cr>
inoremap ;q <C-o><cmd>qall!<cr>
nnoremap ;w <C-o><cmd>wall!<cr>
nnoremap ;wq <C-o><cmd>wq!<cr>
nnoremap ;q <C-o><cmd>qall!<cr>

inoremap ;u <C-o>u
inoremap ;r <C-o><C-r>

nnoremap ;u <C-o>u
nnoremap ;r <C-o><C-r>

inoremap ;ww <Esc><cmd>wall!<cr>
nnoremap ;ww <cmd>wall!<cr>



set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
set linespace=15

set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set smarttab
set tags=tags
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set timeout timeoutlen=200 ttimeoutlen=100
set visualbell           " don't beep
set noerrorbells         " don't beep
set autowrite  "Save on buffer switch
set clipboard=unnamedplus
set mouse=a




function! EscapeString (string)
    let string=a:string
    " Escape regex characters
    let string = escape(string, '^$.*\/~[]')
    " Escape the line endings
    let string = substitute(string, '\n', '\\n', 'g')
    return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
    " Save the current register and clipboard
    let reg_save = getreg('"')
    let regtype_save = getregtype('"')
    let cb_save = &clipboard
    set clipboard&

    " Put the current visual selection in the " register
    normal! ""gvy
    let selection = getreg('"')

    " Put the saved registers and clipboards back
    call setreg('"', reg_save, regtype_save)
    let &clipboard = cb_save

    "Escape any special characters in the selection
    let escaped_selection = EscapeString(selection)

    return escaped_selection
endfunction
vnoremap <c-r> <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>
vnoremap <c-h> <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>
