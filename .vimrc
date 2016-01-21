filetype off
filetype indent plugin on
syn on

" automatically install VAM itself
fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " automatically install when plugins not there or when running
  " :UpdateActivatedAddons
  let c.shell_commands_run_method = 'system'
  let c.auto_instal = 1
  let c.log_to_buf = 1
  let c.log_buffer_name = '/tmp/vam_install.log'

  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
      \ shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

VAMActivate
  \ ag
  \ align
  \ commentary
  \ ConflictDetection
  \ ConflictMotions
  \ CountJump
  \ ctrlp
  \ DeleteTrailingWhitespace
  \ dispatch
  \ endwise
  \ eunuch
  \ fugitive
  \ FuzzyFinder
  \ github:christoomey/vim-run-interactive
  \ github:nathanaelkane/vim-indent-guides
  \ github:thoughtbot/vim-rspec
  \ github:tommcdo/vim-fubitive
  \ ingo-library
  \ L9
  \ ragtag
  \ rails
  \ rake
  \ rsi
  \ sensible
  \ ShowTrailingWhitespace
  \ sleuth
  \ speeddating
  \ splitjoin
  \ Supertab
  \ surround
  \ surround
  \ Syntastic
  \ Tabular
  \ unimpaired
  \ vim-indent-object
  \ vimproc
  \ vim-ruby
  \ ZoomWin



" JavaScript, CSS et al.
call vam#ActivateAddons([
  \ 'jshint%3576',
  \ 'github:groenewege/vim-less',
  \ 'github:mustache/vim-mustache-handlebars',
  \ 'github:elzr/vim-json',
  \ ])

au FileType html setlocal tabstop=2 expandtab colorcolumn=

au FileType javascript setlocal tabstop=2 expandtab

au FileType css setlocal tabstop=2 expandtab
au FileType less setlocal tabstop=2 expandtab

au FileType yaml setlocal tabstop=2 expandtab

au FileType json setlocal tabstop=2 expandtab
let g:vim_json_syntax_conceal = 0


" Haskell
call vam#ActivateAddons([
  \ 'github:pbrisbin/html-template-syntax',
  \ 'github:neovimhaskell/haskell-vim',
  \ 'github:eagletmt/ghcmod-vim',
  \ 'github:bitc/vim-hdevtools',
  \ 'github:eagletmt/neco-ghc',
  \ ])

au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
au FileType haskell setlocal tabstop=4 expandtab

let g:haskellmode_completion_ghc = 0
au FileType haskell setlocal omnifunc=necoghc#omnifunc

au FileType cabal setlocal tabstop=2 expandtab

au FileType hamlet setlocal tabstop=2 expandtab


" Python
call vam#ActivateAddons([
  \ 'github:klen/python-mode',
  \ 'github:hynek/vim-python-pep8-indent',
  \ ])
let g:pymode_folding = 0
let g:pymode_indent = 0
let g:syntastic_ignore_files = ['\.py$']
let g:pymode_lint_checkers = ['pep8']
let g:pymode_lint_cwindow = 1
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_rope_autoimport = 0
let g:pymode_syntax_print_as_function = 1

au FileType python setlocal tabstop=4 expandtab
au FileType htmldjango setlocal tabstop=2 expandtab colorcolumn=

set wildignore+=dist,node_modules,*.pyc


" Docker
call vam#ActivateAddons([
  \ 'github:ekalinin/Dockerfile.vim'
  \ ])


" Other
call vam#ActivateAddons([
  \ 'github:puppetlabs/puppet-syntax-vim',
  \ ])


syntax on
filetype plugin indent on
set hls

" display extra whitespaces
set list listchars=tab:»·,trail:·,nbsp:·

" use one space, not two, after punctuation
set nojoinspaces

" Set up Silver Searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

colorscheme desert
set t_Co=256
highlight Search term=reverse ctermfg=0 ctermbg=12 guifg=wheat guibg=peru


if exists('+colorcolumn')
  set textwidth=80
  " execute "set colorcolumn=" . join(range(81,400), ',')
  set colorcolumn=+1
  highlight ColorColumn ctermfg=242 ctermbg=0 guibg=DarkBlue
endif

" Follow tabstop
set softtabstop=-1 shiftwidth=0

au FileType ruby setlocal tabstop=2 expandtab

au FileType perl setlocal tabstop=4 noexpandtab
let perl_include_pod = 1
au FileType mason setlocal tabstop=2 noexpandtab

au FileType cucumber setlocal tabstop=2 expandtab colorcolumn=

set history=1000
if exists('+undofile')
  set undofile
endif
if exists('+undodir')
  set undodir=$HOME/.vim/undo
endif
if exists('+undolevels')
  set undolevels=1000
endif
if exists('+undoreload')
  set undoreload=10000
endif

set ignorecase smartcase

set number

set completeopt-=preview
let g:SuperTabDefaultCompletionType = "context"

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" vim-rspec mappings
let g:rspec_command = "Dispatch bundle exec rspec -fd {spec}"
" let g:rspec_command = "Dispatch rspec {spec}"
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" conflicting with c-l to clear search...
" nnoremap <C-l> <C-w>l

" spell checking automation
command SpellOn setlocal spell spelllang=en_us
map <F5> :SpellOn<CR>
autocmd BufRead,BufNewFile *.md,*.txt :SpellOn
autocmd FileType gitcommit,markdown,text :SpellOn
set complete+=kspell


imap <C-BS> <C-W>
imap <C-Del> <C-O>de

nnoremap <silent> <C-W>t :tabnew<CR>

" using C-L from a tpope plugin
" nnoremap <silent> <Leader>n :nohlsearch<CR>

let g:ag_working_path_mode="r"

command! W w !sudo sponge %

set exrc
