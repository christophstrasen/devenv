" Buffer delete all others (delete all except current one)
""command Bdo BufOnly
""cabbrev bdo BuffOnly

" Visual diff command.
""command Ldiffthis Linediff
""cabbrev ldiffthis Linediff

""command Ldiffoff Linediffreset
""cabbrev ldiffoff LinediffReset

" Load colors! On the initial install this will error out, so make it silent 
" so it installs without issues.
"" silent! colorscheme monokai

" Add a mapping for the NERDTree command, so you can just type :T to open
"" command T NERDTree

" Enable the powerline fonts.
"" let g:airline_powerline_fonts = 1

" Show the buffers at the top
"" let g:airline#extensions#tabline#enabled = 1

" Show the buffer numbers so I can `:b 1`, etc
"" let g:airline#extensions#tabline#buffer_nr_show = 1

" Aside from the buffer number, I literally just need the file name, so
" strip out extraneous info.
"" let g:airline#extensions#tabline#fnamemod = ':t'

" Set the theme for vim-airline
"" autocmd VimEnter * AirlineTheme powerlineish

"" let g:NERDTreeMouseMode = 3

" Use spaces instead just for yaml
"" autocmd Filetype yaml setl expandtab

" Highlighting on top of the error gutter is a bit overkill...
"" let g:ale_set_highlights = 0

" I want errors to be styled a bit more like neomake
"" let g:ale_sign_error = '✖'
"" highlight ALEErrorSign ctermfg=DarkRed ctermbg=NONE

" Same with warnings
"" let g:ale_sign_warning = '⚠'
"" highlight ALEWarningSign ctermfg=Yellow ctermbg=NONE

" Force the emoji to show up in the completion dropdown
"" let g:github_complete_emoji_force_available = 1

" Rely on tmux for the repl integration to work
"" let g:slime_target = 'tmux'

" This will ensure that the second panel in the current
" window is used when I tell slime to send code to the
" repl.
if exists("$TMUX")
	let s:socket_name = split($TMUX, ',')[0]

	let g:slime_default_config = {
					\ 'socket_name': s:socket_name,
					\ 'target_pane': ':.1'
					\ }
endif

" I dont like the default mappings of this plugin...
"" let g:slime_no_mappings = 1

" Ctrl+s will send the paragraph over to the repl.
""nmap <c-s> <Plug>SlimeLineSend

" Ctrl+x will send the highlighted section over to the repl.
""xmap <c-s> <Plug>SlimeRegionSend

" Make it so that ctrlp ignores files in .gitignore
""let g:ctrlp_user_command = '(git status --short | awk "{ print \$2 }"; git ls-files -- %s) | sort -u'

" Only interested in files in scm when editing source code.

" DOES NOT WORK / kick out of plugin install"
" call denite#custom#var('grep', 'command', ['git', 'grep'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('file_rec', 'command', ['git', 'ls-files'])

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

nmap <c-j> <Plug>(ale_fix)
nmap <c-s> :call ALEFixSuggest()

set encoding=utf-8

" set pyxversion=3

" Use deoplete.
let g:deoplete#enable_at_startup = 1

let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" Set bin if you have many instalations
"let g:deoplete#sources#ternjs#tern_bin = '/path/to/tern_bin'
"let g:deoplete#sources#ternjs#timeout = 1

" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and 
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some 
" heuristics to try and return some properties anyway. Set this to 0 to 
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 1

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of 
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been 
" spelled out by at least two characters. Default: 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not 
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]

"autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
"autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
"autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
"autocmd FileType html vnoremap <buffer> <c-h> :call RangeHtmlBeautify()<cr>
"autocmd FileType html vnoremap <buffer> <c-j> :call RangeJsBeautify()<cr>
"autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>


