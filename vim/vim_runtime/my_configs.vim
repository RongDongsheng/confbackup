" auto find ctags
set tags=tags;
" autochdir to enable git blame plugin for submodule
set autochdir

" map TlistToggle
nnoremap <F3> :TlistToggle<CR>

" map Arrow keys to page up down
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>

syntax enable
set background=dark
" solarized options
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
" colorscheme solarized
" let g:solarized_bold=0

" relative line number
set relativenumber
set nu

" let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_Auto_Update=1
let Tlist_Use_SingleClick=1
"let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow=1
" let Tlist_Show_One_File=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Use_Left_Window=1

" :set mouse=a
set nocscopeverbose 

" 80 characters line
set colorcolumn=81
execute "set colorcolumn=" . join(range(81,335), ',')
" highlight ColorColumn ctermbg=Black ctermfg=Red

" gitblame with ,+s
if exists('g:loaded_gitblame')
    finish
endif
let g:loaded_gitblame = 1

command! -nargs=0 GitBlame call gitblame#echo()

nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

nnoremap <C-]> g<C-]>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
