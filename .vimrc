"---------------------------------------------------------------------------------------
" INSTALL PLUGINS

    call plug#begin('~/.vim/plugged')
        Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
        Plug 'joshdick/onedark.vim'
        Plug 'tpope/vim-surround'
        Plug 'cosminadrianpopescu/vim-tail'
        Plug 'junegunn/fzf'
        Plug 'wincent/ferret'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'BurntSushi/ripgrep'
        Plug 'jondkinney/dragvisuals.vim'
        Plug 'francoiscabrol/ranger.vim'
    call plug#end()
"----------------------------------------------------------------------------------------
" SETUP VIM DEFAULTS

source $VIMRUNTIME/vimrc_example.vim

" Turn On Syntax colors
    syntax on

" Color Scheme
    colorscheme onedark

" Set Relative Line numbers
    augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END

" Automatically deletes all trailing whitespace on save.
    autocmd BufWritePre * %s/\s\+$//e

" Maximize Window
    autocmd GUIEnter * simalt ~x

"Auto Complete FilePath
    set wildmode=longest,list,full

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
    set splitbelow splitright

" Setup VIM backups and swaps if enabled
    set directory=~/.vim/backup/
    set backupdir=~/.vim/backup/
    set directory=~/.vim/swp/
" Disable Vim Backup Files
    set nobackup
    set nowritebackup

" Set line numbers to relative
    set number relativenumber

" Set Language
    set spell spelllang=en_us

" Set tabs to 4 spaces
    set tabstop=4
" Switch tabs to spaces
    set expandtab

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list

" Highlight long lines just the 81st column of wide lines...
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)

"------------------------------------------------------------------------------------------------------------------
" Uses Windows Diff if vim can't find a way to do it
    set diffexpr=MyDiff()
    function! MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg1 = substitute(arg1, '!', '\!', 'g')
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg2 = substitute(arg2, '!', '\!', 'g')
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      let arg3 = substitute(arg3, '!', '\!', 'g')
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          if empty(&shellxquote)
            let l:shxq_sav = ''
            set shellxquote&
          endif
          let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      let cmd = substitute(cmd, '!', '\!', 'g')
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
      if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
      endif
    endfunction
"-------------------------------------------------------------------------------------------
" KEY MAPPINGS

" Set leader key for mappings
    let mapleader = " "
" Exit insert mode
    inoremap kj <ESC>
    vnoremap kj <ESC>
"Remove Highlights
    noremap <Leader>x :noh<CR>

" Edit VIMRC from vim
    noremap <Leader>ved :edit $MYVIMRC<CR>

" Reload VIMRC
    noremap <Leader>ver :source $MYVIMRC<CR>

" Paste from windows Clipboard
    noremap <Leader>p "+p

" Copy to Windows Clipboard
    noremap <Leader>c "+y
" Select All
    noremap <Leader>a ggVG
" Make a new tab
    noremap <C-n> :tabnew
" Tail start and stop
    noremap <Leader>lt :TailStart
    noremap <Leader>lu :TailStop
" ranger
    map <leader>f :Ranger<CR>
" Redo
    noremap <C-r> :redo<CR>


" Spell Check
    map <leader>o :setlocal spell! spelllang=en_us<CR>

" Save
    noremap <Leader>s :w<cr>

" faster close and save
    noremap <Leader>s :w <cr>
    noremap <Leader>xs :wq <cr>
    noremap <Leader>xc :q <cr>

" Split window vertical
    noremap <Leader>wl :vsplit <cr>

" Split window horizontal
    noremap <Leader>wj :split <cr>

" swap colon for semi colon
    noremap ; :
    nnoremap : ;
