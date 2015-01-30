"-------------------------------------------------------------------------------
"general setting
"-------------------------------------------------------------------------------
set nocompatible
set hls "high light search
set showcmd "show command
set nu "show line number
set ru
set cindent shiftwidth=4 "auto align
set shiftwidth=4 "unknown
set backspace=indent,eol,start "unknown
set expandtab "expand tab enable
set tabstop=4 "expand tab width set textwidth=120 "auto wrap width
set nowrap
set scrolloff=7 "vertical scroll offset
set sidescroll=2 "horizontal scroll step
set ignorecase "ignore-case when search
set autoindent
set fo +=2nmM "suitable for chinese edit
set completeopt=longest,menu "auto-complete option
set linespace=0 "Space between lines
"set columns=110
set guioptions-=T
"set guioptions-=m
set fileformats=unix,dos
set ut=700
set incsearch
set guioptions-=T "���ع�����
set guioptions-=m "���ز˵���
set laststatus=2
set fileencodings=utf-8,cp936,gbk,gb2312,gb18030,cs-bom,latin1,big5
set fileencoding=utf-8
"to install Monaco font, use "curl -kL https://raw.github.com/cstrap/monaco-font/master/install-font-ubuntu.sh | bash"
"set guifont=Menlo:h15
"set guifont=UbuntuMono\ 14
set guifont=Arial:h14:cANSI
winpos 5 5
syn on
syntax enable
set t_Co=256
set background=dark
colorscheme monokai
"Ϊmac�������뷨����
set noimdisable
autocmd! InsertLeave * set imdisable|set iminsert=0
autocmd! InsertEnter * set noimdisable|set iminsert=0
"-------------------------------------------------------------------------------
"plugin setting
"-------------------------------------------------------------------------------
"vim-powerline
set laststatus=2
let g:Powline_symbols='fancy'
"Markdown
let g:vim_markdown_folding_disabled=1
let g:voom_tree_placement = "right"
"the NERD Tree
let NERDTreeWinSize = 40
let NERDTreeShowHidden = 1
"Indent guide
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#080818 ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#180808 ctermbg=4
hi IndentGuidesOdd guibg=red ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4
"CtrlP
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
let g:ctrlp_by_filename=1
"��tab�д�ctrlpѡ���ļ�
function! Fileopenfunc(action, line)
if a:action == 'e'
" Get the filename
let filename = fnameescape(fnamemodify(a:line, ':p'))
" Close CtrlP
call ctrlp#exit()
" Open the file
silent! execute 'tabnew ' filename
endif
endfunction
let g:ctrlp_open_func = {'files': 'Fileopenfunc'}
"Tlist
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Update = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Show_One_File = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Process_File_Always = 1
"win manager
let g:winManagerWindowLayout = "FileExplorer,BufExplorer"
"markdown make
func! WikiMake()
if filereadable("makefile")
exec "silent !make"
endif
endfunc
au BufWritePost *.md call WikiMake()
"indentLine
let g:indentLine_color_gui = '#A4E57E'
"tagbar
let g:tagbar_autoclose = 1
"ultisnips
"1)Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
"2)If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"python
set nofoldenable
let g:pyflakes_use_quickfix = 0
let g:pep8_map='<F4>'
map <C-]> :RopeGotoDefinition<CR>
let pymode_rope_goto_def_newwin='vnew'
"Gundo
map <F1> :GundoToggle<CR>
"-------------------------------------------------------------------------------
" ��ǩҳ�л�����
"-------------------------------------------------------------------------------
" ���ڱ�ǩҳ�ı����޸�
" ʹ�����Զ��庯�� GuiTabLabel()
set showtabline=2 " always show tabs in gvim, but not vim
set guitablabel=%{GuiTabLabel()}"
" �޸ı�ǩҳ�ı���
" set up tab labels with tab number, buffer name, number of windows
"
function! GuiTabLabel()"
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
let name = '[Quickfix List]'
else
let name = '[No Name]'
endif
else
" get only the file name
let name = fnamemodify(name,":t")
endif
let label .= name
" Append the number of windows in the tab page
let wincount = tabpagewinnr(v:lnum, '$')
return label . ' [' . wincount . ']'
endfunction"
"
" ��gvim֧��Alt+n���л���ǩҳ
"
function! Tabmap_Initialize()
for i in range(1, 9)
exe "map <A-".i."> ".i."gt"
endfor
exe "map <A-0> 10gt"
endfunction
"autocmd VimEnter * call BufPos_Initialize()
autocmd VimEnter * call Tabmap_Initialize()
"
" alt+���Ҽ����ƶ���ǩ
"
nn <silent> <M-left> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|el\|exe "tabm ".(tabpagenr()-2)\|en<CR>
nn <silent> <M-right> :if tabpagenr() == tabpagenr("$")\|tabm 0\|el\|exe "tabm ".tabpagenr()\|en<CR>
"-------------------------------------------------------------------------------
"nmap
"-------------------------------------------------------------------------------
"bufferExplorer
nmap fb \be
nmap fv \bv
nmap fs \bs
nmap ft :tabnew<CR>
nmap fd :tabc<CR>
"copy
nmap <C-V><C-V> "+p
nmap <F7> :NERDTreeToggle<cr><c-w>hh | "Toggle file-manager window "nmap <F7> :WMToggle<cr><c-w>j<cr>
nmap <F8> :TagbarToggle<CR>
" project
nmap <F9> :cs kill -1<cr>:!cscope -Rb<cr>:cs a cscope.out<cr>
nmap <F10> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<cr>
"Move left/right
nmap <C-L> <C-W>l
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap j gj
nmap k gk
nmap <S-q> :only<CR>
nmap <M-q> :close<CR>
nmap <C-s> <Esc>:Ack!
"-------------------------------------------------------------------------------
"imap
"-------------------------------------------------------------------------------
"����xdate+<esc>�Զ�ת��Ϊʱ��
iab xdate <c-r>=strftime("20%y-%m-%d %H:%M:%S")<C-I>
"-------------------------------------------------------------------------------
"vmap
"-------------------------------------------------------------------------------
vmap <C-C> "+y

"-------------------------------------------------------------------------------
"vundle
"-------------------------------------------------------------------------------

filetype off  
" �˴��涨Vundle��·��  
set rtp+=$VIM/vimfiles/bundle/vundle/  
call vundle#rc('$VIM/vimfiles/bundle/')  
Bundle 'gmarik/vundle'  
filetype plugin indent on  
  
" original repos on github<br>Bundle 'mattn/zencoding-vim'  
Bundle 'drmingdrmer/xptemplate'  
   
"״̬����ǿ
Bundle 'Lokaltog/vim-powerline'
"�������б�
Bundle 'Tagbar'
"���ڹ�����
Bundle 'winmanager'
"markdown�﷨����
Bundle 'Markdown'
"�ļ������
Bundle 'The-NERD-tree'
"������������
Bundle 'bufexplorer.zip'
"�ָ���
Bundle 'Indent-Guides'
"�ļ���������
Bundle 'ctrlp.vim'
"�﷨�ṹ��ȫ
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
"�ַ����Զ���ȫ
Bundle 'AutoComplPop'
Bundle 'L9'
"���Ų�ȫ
Bundle 'Auto-Pairs'
"ȥ����β�ո�,ʹ��:Fixwhitespace
Bundle 'trailing-whitespace'
"��̬�﷨���
Bundle 'Syntastic'
"�༭��ʷ��¼�ع�
Bundle 'Gundo'
"python�﷨���
Bundle 'pyflakes.vim'
Bundle 'pep8'
"python�ĵ�
Bundle 'pydoc.vim'
"�ĵ���������Ҫ��ϵͳ�ﰲװack-grep
"Bundle 'ack.vim'
"python��ȫ����ת���ع�(ǰ��pip install
"rope,ropemode,������ropevimĿ¼��ִ��setup.py��װ)
"Bundle 'ropevim'
Bundle 'jedi-vim'
filetype plugin indent on

