let mapleader=","

" if you disagree with this you suck
nnoremap : ;
nnoremap ; :

" move vertically by visual line
nnoremap j gj
nnoremap k gk

let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'

set nocompatible

filetype indent plugin on
syntax enable " enable syntax processing
set autoindent
set wildmenu " visual autocomplete for command menu
set wildignore=*.o,*~,*.pyc " ignore compiled files

set ai " auto Indent
set si " smart indent
set smartindent
set shiftwidth=4
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set expandtab " tabs are spaces

" set to auto read when a file is changed
set autoread
set autochdir

set showmatch " show matching [ { ( ) } ]
set ignorecase
set smartcase

set lazyredraw " redraw only when need to

" make backspace behave
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

set number " show line numbers
set ruler " always show current position
set showcmd " show command in bottom bar
set cursorline " highlight current line

set incsearch " search as characters are entered
set hlsearch " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

set foldenable " enable folding
set foldlevelstart=99 " open all folds by default
set foldnestmax=10 " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent " fold based on indent level

" highlight last inserted text
nnoremap gV `[v`]

highlight OverLength ctermbg=cyan ctermfg=white guibg=#FFCC99

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

command! Removetrailing :%s/[ \t]*$//g
command! Fourspaces :%s/\t/    /g
command! Release :normal i tagging for release [override_audit]

" terminal colours to 256
set t_Co=256
let base16colorspace=256
colorscheme base16-solarized
set background=light

" Automatically highlight trailing whitespaces
2mat ExtraWhiteSpace /\s\+$/
au BufWinEnter * 2mat ExtraWhiteSpace /\s\+$/
au InsertEnter * 2mat ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * 2mat ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" highlight the number for curr line
hi CursorLineNr cterm=bold

" Highlight 81st line for formatting
highlight ColorColumn ctermbg=21
set colorcolumn=81

" change the highlight colorur to be readable
highlight Search cterm=NONE ctermfg=black ctermbg=yellow

set ic

set history=700

set splitright
set splitbelow

" make status line super dank
set laststatus=2  " always show status line
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%F%r%w\                      " file name
set statusline+=%h%r%w%m                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/
" whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif

function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-X>\<C-I>"
    endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" toggle between number and relative number
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <leader>n :call ToggleNumber()<CR>
