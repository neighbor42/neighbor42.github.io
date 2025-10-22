---
layout  : wiki
title   : 나의 Vimrc 설정
summary : Windows _vimrc 
date    : 2025-10-22 09:38:16 +0900
updated : 2025-10-22 14:31:17 +0900
tags    : _vimrc windows
toc     : true
public  : true
parent  : [[/vimwiki]]
latex   : false
resource: a2552bf3-ef86-4082-b0b0-b6f1cf07248d
---
* TOC
{:toc}



## Windows 수정사항
### link 생성 방식 - [test](test) => [[\test]]
test를 작성하고 커서를 글자 위에 옮기고 엔터를 치면 `[[\test]]`와 같은 링크가 생성되어야 한다. 하지만 `[test](test)` 이렇게 나오는 이슈가 있었다.

해결방안
- \_vimrc에서 syntax를 markdown으로 지정해놔서 생긴 이슈
- \_vimrc에서 vimwiki syntax를 default로 변경
```
let g:vimwiki_list = [{
	\ 'path': '<vimwiki 위치>',
	\ 'syntax': 'default',
	\ 'ext': '.md'
\ }]
```

### uuid
[이 글](https://johngrib.github.io/wiki/vimwiki/)의 댓글 섹션을 보면 윈도우에서 vimwiki를 설정 중인데 NewTemplate()이 제대로 작동하지 않는다는 내용이 있다. 

![img](./resource/a2552bf3-ef86-4082-b0b0-b6f1cf07248d/EIQcDqC.png)

![johngrib-comment](https://github.com/user-attachments/assets/5e2533b8-78a3-459c-9154-91be70a74acd)
![comment](https://github-production-user-asset-6210df.s3.amazonaws.com/106816837/503954539-5e2533b8-78a3-459c-9154-91be70a74acd.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20251022%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20251022T042414Z&X-Amz-Expires=300&X-Amz-Signature=ee13bea53ef39ee5d298ad80f00db775335e9e3079e10b0961855dbe869b2ca7&X-Amz-SignedHeaders=host)


Windows 에서도 resources(uuid) 칸을 사용할 생각이 없다면 아래와 같이 작성만해줘도 잘 돌아간다.

```bash
function! NewTemplate()
    
    " 만약 줄 개수가 1개 이상이라면 return
    if line("$") > 1
        return
    endif

 let l:template = []
    call add(l:template, '---')
    call add(l:template, 'layout  : wiki')
    call add(l:template, 'title   : ')
    call add(l:template, 'summary : ')
    call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'tags    : ')
    call add(l:template, 'toc     : true')
    call add(l:template, 'public  : true')
    call add(l:template, 'parent  : ')
    call add(l:template, 'latex   : false')
    call add(l:template, '---')
    call add(l:template, '* TOC')
    call add(l:template, '{:toc}')
    call add(l:template, '')
    call add(l:template, '# ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki page has created'
endfunction

autocmd BufRead,BufNewFile *.md :call NewTemplate()
```

댓글에 적힌대로 windows에서 uuid를 불러오기위해 나는 아래와 같이 변경해서 사용하고 있다.
```
call add(l:template, 'resource: ' . substitute(system('powershell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; [guid]::NewGuid().ToString()"'), '[\r\n\x00]', '', 'g'))
```

### Vimwiki
Vim에서 `:Vimwiki`를 입력하면 인덱스가 오픈하는데, index.md로 이동이 된다. root-index.로 이동하는게 더 편리해서 수정
- 정확히 index와 root-index의 용도는 아직 이해하지 못했다.
```
let g:vimwiki_list = [
 \ {
 \ 'path': '<\_wiki 폴더 위치>',
 \ 'index': 'root-index',
 ...
\]
```

### 이미지 추가 방식
전에는 imgur를 사용했었는데, 링크를 일시적으로만 만들어줘서 예전 이미지가 전부 '찾을 수 없음'으로 뜬다.
- github issue의 기능 사용(imgur?)
- `choco install ag`
- 사진 복붙
- 생성된 링크 사용
![test](https://imgur.com/a/IBYvJla)

### 나의 초기 \_vimrc

```bash
" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim  "mswin 윈도우에 맞도록 설정
behave mswin
set clipboard=unnamed  "윈도우 복붙 활성화
set nu  " 라인 수 표시

"자동 들여쓰기
set autoindent
set smartindent

" tab 4칸 인식
set tabstop=4

" >> << 키로 들여쓰기 4칸
set shiftwidth=4

"괄호 입력시 자동으로 대응되는 괄호 표시
set ignorecase

"문법 적용
syntax on

set encoding=utf-8
set fileencoding=utf-8


"vi와 호환하지 않는다. 즉, vim을 vim답게 만든다.
set nocompatible

"undofile을 만들지 않는다
set noundofile
set nobackup

" 한글입력 후 NORMAL 모드로 돌아갔을 때 영문이 기본으로 되게
set noimd



"let wiki = {}
let g:vimwiki_list = [
  \ {
  \ 'path': '<\_wiki 폴더 위치>',
  \ 'index': 'root-index',
  \ 'syntax': 'default',
  \ 'ext': '.md'
  \ }
  \]
let g:vimwiki_conceallevel = 0

let maplocalleader = "\\"


function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
              \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun

autocmd BufWritePre *.md call LastModified()

" 새 문서 작성시 메타 데이터 자동 입력
function! NewTemplate()
    
    " 만약 줄 개수가 1개 이상이라면 return
    if line("$") > 1
        return
    endif

 let l:template = []
    call add(l:template, '---')
    call add(l:template, 'layout  : wiki')
    call add(l:template, 'title   : ')
    call add(l:template, 'summary : ')
    call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'tags    : ')
    call add(l:template, 'toc     : true')
    call add(l:template, 'public  : true')
    call add(l:template, 'parent  : ')
    call add(l:template, 'latex   : false')
    call add(l:template, 'resource: ' . substitute(system('powershell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; [guid]::NewGuid().ToString()"'), '[\r\n\x00]', '', 'g'))
    call add(l:template, '---')
    call add(l:template, '* TOC')
    call add(l:template, '{:toc}')
    call add(l:template, '')
    call add(l:template, '# ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki page has created'
endfunction

autocmd BufRead,BufNewFile *.md :call NewTemplate()


command! WikiIndex :VimwikiIndex
nmap <LocalLeader>ww <Plug>VimwikiIndex
nmap <LocalLeader>wi <Plug>VimwikiDiaryIndex
nmap <LocalLeader>w<LocalLeader>w <Plug>VimwikiMakeDiaryNote
nmap <LocalLeader>wt :VimwikiTable<CR>






call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'mhinz/vim-startify'
call plug#end()



" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
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

```


## Resources
- [Vimwiki 사용법](https://johngrib.github.io/wiki/vimwiki/)
- [Vimwiki + Jekyll + Github.io로 나만의 위키를 만들자](https://johngrib.github.io/wiki/my-wiki/)
- [내 vimrc](https://aegis1920.github.io/wiki/myvimrc)
- [Windows 환경에서 Vimwiki + Jekyll + github.io 위키 구축하기](https://neoarc.github.io/wiki/wiki_on_github_io/)
