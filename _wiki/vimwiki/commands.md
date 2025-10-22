---
layout  : wiki
title   : Vimwiki 사용시 알아두면 좋을 명령어
summary : 외우면 편하다
date    : 2025-10-22 11:16:40 +0900
updated : 2025-10-22 11:21:22 +0900
tags    : vimwiki
toc     : true
public  : true
parent  : [[/vimwiki]]
latex   : false
resource: 0ec29094-80eb-4b55-a354-decf8585aee8
---
* TOC
{:toc}


## 파일 이름 변경
1. `:vimwikire` + `tab` => `:VimwikiRenameLink` 커맨드가 자동완성된다.
2. `Enter` + `y`를 눌러 동의
3. 위키 전체에 해당 파일 링크된 곳을 새로운 이름으로 변경

## 파일 삭제
1. `:vimwikidel` + `tab` => `:VimwikiDeleteLink` 커맨드 자동완성
2. `Enter` + `y`를 눌러 동의
3. 현재 편집중인 파일 삭제 + 해당 파일 링크 전체 해제
