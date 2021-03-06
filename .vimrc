" /// @file .vimrc
" /// @brief -
" /// @author jiahfong
" /// @version 0.0.42
" /// @date 2020-10-03
"
" How to install:
"   Download specified dependenceis below and place this .vimrc file in your
"   home directory. 
"
" Dependencies:
"   1. cmake (remove YouCompleteMe otherwise)
"
" Shortcuts:
"   * [e ]e         => swap lines
"   * [b ]b         => switch buffers
"   * [m ]m         => next method
"   * ctrl-p        => fuzzy search
"   * ctrl-n        => multi-cursor
"   * <leader>-b    => find all references
"   * gd            => go to definition
"   * shift-k       => help (doc page)
"
" Features:
"   * NERDTree (:NerdTree)
"   * auto completion (YCM)
"   * snippets (UltiSnips + vim-snippets)
"   * Doxygen

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  silent !curl -fLo ~/.vim/.ycm_extra_conf.py --create-dirs
    \ https://raw.githubusercontent.com/jiahfong/dotfiles/master/.ycm_extra_conf.py
  silent !curl -fLo ~/.vim/UltiSnips/python.snippets --create-dirs
    \ https://raw.githubusercontent.com/jiahfong/dotfiles/master/UltiSnips/python.snippets
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

    """""""""""""""""""""""""""
    " Plugins
    """""""""""""""""""""""""""

    " surrounds word with adjective
    Plug 'tpope/vim-surround'

    " commenting
    Plug 'tomtom/tcomment_vim'

    " [e ]b [<space> etc. (just try it)
    Plug 'tpope/vim-unimpaired'

    " . now has repeat on steroids
    Plug 'tpope/vim-repeat'

    " doxygen generator
    Plug 'vim-scripts/DoxygenToolkit.vim'

    " NERDtree
    Plug 'scrooloose/nerdtree'

    " laststatus=2
    Plug 'bling/vim-airline'

    " fuzzy finder
    Plug 'ctrlpvim/ctrlp.vim'

    " auto completer
    Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
    Plug 'davidhalter/jedi-vim'
    Plug 'ervandew/supertab'

    " Snippets
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " more % functions
    Plug 'tmhedberg/matchit'

    " auto close tags
    Plug 'alvan/vim-closetag'

    " () pair
    Plug 'jiangmiao/auto-pairs'

    " ctrl-n multi changing
    Plug 'terryma/vim-multiple-cursors'

    " nav between tmux and vim splits with ctrl-hjkl
    Plug 'christoomey/vim-tmux-navigator'

    " cmake completion
    Plug 'jansenm/vim-cmake'

    " Themes
    Plug 'chriskempson/base16-vim'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'rust-lang/rust.vim'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Using powerline font
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" tabline options
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor options
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets the encoding to the utf-8 character set
set enc=utf-8
set term=screen-256color
set t_Co=256
" copy to system clipboard
" set clipboard=unnamed
" Y as y$
nnoremap Y y$
" Paste mode
set pastetoggle=<F2>
" Reload files changed externally to vim.
set autoread
" shows status line with filename, column/row coords, dirty bit
set laststatus=2
set ruler
" sets xterm title to display the name of the file currently being edited
set title
" shows mode (i.e. insert mode etc)
set showmode
" shows the keystrokes currently waiting to be processed
set showcmd
" always reports the number of lines changed
set report=0
" flashes the screen instead of beeping the computer
set visualbell t_vb=
" Allow the backspace button to backspace over indents, eols and the start of insert.
set backspace=indent,eol,start
" searches are incremental
set incsearch
" show matching bracket briefly
set showmatch
" don't wrap long lines
set nowrap
" Show non-white space characters when using :set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" character to mark lines that exceed 80 characters
set listchars+=extends:@
" indent on new line is equal to indent on previous line
set smartindent
" tabstops are converted to spaces, ensuring the file always looks the same.
set expandtab
" tabstops set to 4 spaces
set tabstop=4
" width of an indent level
set shiftwidth=4
" smarttab uses shiftwidth at the start of a line and tabstop everywhere else.
set smarttab
" autoformats text, wraps lines, autoindents, continues comments etc.
set formatoptions=croqn2
" write a backup of the current file (with an appended ~) on each write
set nobackup
"ignores the case in search patterns.
set ignorecase
set smartcase
" Highlights matching terms when searching.
set hlsearch
" Turns the mouse off.
set mouse=r
" turn on line-numbers.
set nu
set rnu
" tab autocompletion in the command space
set wildmenu
set wildmode=longest,full
" Toggles display of unprintable characters.
nnoremap <F5> :set list!<CR>
" allows . (repeat) on visually highlighted lines
vnoremap . :normal .<CR>

autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" Override base16's colourscheme for solarized-dark (more red hues)
function! s:base16_customize() abort
  call Base16hi("Type", g:base16_gui08, "", g:base16_cterm08, "", "", "")
  call Base16hi("SpellBad", g:base16_gui01, g:base16_gui02, g:base16_cterm01, g:base16_cterm02, "bold,italic", "")
endfunction
augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END
" define the colourscheme using base16
syn on
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Doxygen
"""""""""""""""""""""""""""""""""""""""""""""""""""
" /// style docstring
let g:DoxygenToolkit_commentType = "C++"
" MIT license
let g:DoxygenToolkit_licenseTag = "Copyright (c) ".strftime("%Y")." - Jia-Hong Fong\<enter>\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "Permission is hereby granted, free of charge, to any person obtaining a copy\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "of this software and associated documentation files (the \"Software\"), to deal\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "in the Software without restriction, including without limitation the rights\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "copies of the Software, and to permit persons to whom the Software is\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "furnished to do so, subject to the following conditions:\<enter>\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "The above copyright notice and this permission notice shall be included in all\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "copies or substantial portions of the Software.\<enter>\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "OR OTHER DEALINGS IN THE SOFTWARE."
let g:DoxygenToolkit_briefTag_funcName = "yes"


"""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux-split-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Easier split navigation  - ctrl [hjkl]
" and changes behavior if tmux is on (ie, tmux will work with vim easy navi)

if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt-=preview
let g:ycm_error_symbol = '✖'
let g:ycm_warning_symbol = '❢'
" maps ctrl-b as goto definition
" note: ctrl-o jumps back to where you were, ctrl-i jumps forward
" to where the definition was (see :h jumplist)
nnoremap <C-b> :YcmCompleter GoTo<CR>
" maps leader-b as goto all usages - only for supported filetypes (python,
" java, and typescript)
" note: leader = \
nnoremap <leader>b :YcmCompleter GoToReferences<CR>
" autocomplete works in comments
let g:ycm_complete_in_comments=1
" turn on tag completion
let g:ycm_collect_identifiers_from_tags_files=1
" complete syntax keywords
let g:ycm_seed_identifiers_with_syntax=1
nnoremap <leader>k :YcmCompleter GetDoc<CR>
" closes the preview window - this isn't for autocompletion, but rather
" when you use YcmCompleter GetDoc; instead of closing the preview window
" manually, close it by exiting insert mode
let g:ycm_autoclose_preview_window_after_insertion = 1
" default options
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" https://vim.fandom.com/wiki/Switching_case_of_characters#Twiddle_case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
