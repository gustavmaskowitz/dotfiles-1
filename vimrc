" troyengel .vimrc

" This must be first  - it changes other options as a side effect
set nocompatible    " use Vim settings, rather then Vi settings

set shortmess+=I    " get rid of the intro screen on blank file
set background=dark " this works better for text mode white-on-black terms
set backspace=2     " allow backspacing over everything in insert mode
set esckeys         " allow cursor keys in insert mode
set noautoindent    " always set autoindenting off
set shiftwidth=4    " number of spaces used for autoindent insertions
set tabstop=4       " tabstop positions

set nobackup        " backups are for wimps
set history=250     " keep 250 lines of command line history

set noerrorbells    " damn that beep to hell
set visualbell      " enable terminal visual bell, but...
set t_vb=           " ...unset the code to do it. (MacVim needs this)
set magic           " use 'magic' patterns  (extended regexp) in search
set ignorecase      " ignore case during searches
set smartcase       " all lower/upper = case insensitive, \c \C overrides

set laststatus=2    " show status line, even if only one buffer
set report=0        " show report on all (0) changes
set lazyredraw      " do not update screen while executing macros
set ruler           " show the cursor position all the time
set showcmd         " show current uncompleted command
set showmode        " show current mode
set showmatch       " show matching brackets

" tone down that dang bold highlighting, folks
" highlight=8b,db,es,hs,mb,Mn,nu,rs,sr,tb,vr,ws
set highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws

" do not jump to first character with page commands, ie keep the cursor
" in the current column.
set nostartofline

" what info to store from an editing session in the viminfo file
set viminfo='50,\"100,:100,n~/.viminfo

" allow the last line to be a modeline - useful when
" the last line gives the preferred textwidth
set modeline
set modelines=1

" add the dash ('-'), the dot ('.'), and the '@' as "letters" to "words".
" this makes it possible to expand email addresses, eg: joe-www@foo.org
set iskeyword=@,48-57,_,192-255,-,.,@-@

" which chars/keys to allow eol wrapping (:help whichwrap)
set whichwrap=<,>,[,]

" enable wrapping but without linebreaks
set wrap
set linebreak
set nolist        " list disables linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l

" When the backspace key sends a "delete" character
" then you simply map the "delete" to a "backspace" (CTRL-H):
map <Del> <C-H>

" Don't use Ex mode, use Q for formatting
map Q gq

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" GVIM preferences
if has("gui_running")
  " CUA Mode (shift+arrows select in insert mode, etc.)
  source $VIMRUNTIME/mswin.vim
 
  set showtabline=2             " always show the tab bar
  set guioptions-=tT            " turn off the menu tearoffs
  colorscheme zellner           " mimics gedit/medit/etc.
  set t_Co=256                  " 256 colors
  set lines=25 columns=80       " we like 80x24

  let os=substitute(system('uname'), '\n', '', '')
  if os == 'Darwin' || os == 'Mac'
    set guifont=Menlo:h16
    set guicursor+=a:blinkon0
  elseif os == 'Linux'
    set guifont=Monospace\ 12
  endif

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
    let label .= v:lnum.': '
    " Append the buffer name
    let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    if name == ''
      " give a name to no-name documents
      if &buftype=='quickfix'
        let name = '[Quickfix]'
      else
        let name = '[No Name]'
      endif
    else
      " get only the file name
      let name = fnamemodify(name,":t")
    endif
    let label .= name
    return label
  endfunction
  set guitablabel=%{GuiTabLabel()}

endif

