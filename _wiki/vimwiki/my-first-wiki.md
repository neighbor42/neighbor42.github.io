---
layout  : wiki
title   : 나만의 위키 만들기 johngrib-jekyll-skeleton 포크해서 시작하기
summary : 
date    : 2025-04-28 10:45:30 +0900
updated : 2025-10-22 11:40:09 +0900
tag     : vimwiki johngrib
toc     : true
public  : true
parent  : [[/vimwiki]]
latex   : false
resource: 3B4E5F93-23F7-BD0F-399C-B6ACCC49763D
---
* TOC
{:toc}

# 순서

## 1. 깃허브 fork + 로컬 서버로 실행
- johngrib skeleton fork
- repo > settings > Pages > Bracnh 설정(master/root/) 후 Save

### 1-1 Ruby + Jekyll 설치
- [ruby 다운로드 사이트](https://rubyinstaller.org/downloads/)
- gem install jekyll bundler(ruby 다운로드 후 아래 명령어로 jekyll 설치)

```
gem install jekyll bundler
bundle install
bundle exec jekyll serve
```

\+ 에러(251021)
- `warning: csv was loaded from the standard library, but is not part of the default gems starting from Ruby 3.4.0. You can add csv to your Gemfile or gemspec to silence this warning.`
해결
- `bundle add`를 사용해 필요한 gems 추가(나의 경우 2개가 빠져있었다)
    - `bundle add csv`
    - `bundle add base64`
    - `bundle install`


## 2. vim 설치
- gvim, nvim
- 플러그인 설치
    - vimwiki 설치 위한 vim-plug 설치
        - `plug.vim` 파일 다운로드 후 `autoload` 폴더에 집어넣기
        - gVim열기 > :PlugInstall 엔터 > Vimwiki 메뉴 설정 뜸
    - vimwiki, startify 플러그인 설치
    - .vimrc(mac) / \_vimrc(window) 아래 코드 추가

index.md와 root-index.md의 차이를 잘 모르겠는데, startify에서 root-index.md 열어주길 바래서 아래처럼 경로를 변경해줌

```

let g:vimwiki_list = [
      \ {
      \ 'path': '<내 위키 폴더 위치~/github/_wiki(대충 이런 위치)>',
      \ 'index': 'root-index',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }
      \ ]
let g:vimwiki_conceallevel = 0
```

그 뒤 Vimwiki 설정 참고
- [johngrib wiki](https://johngrib.github.io/wiki/vimwiki/)
- 메타데이터 updated 항목 자동 업데이트(\_vimrc)
- 새 문서 기본 형식 입력(\_vimrc)


## vimwiki 기본 정보 변경
- giscus, google-site-verification, keybase, etc.
    - giscus
        - 공개 저장소, giscus 앱 설치(configure 우측 상단 버튼 클릭), discussion 기능 활성화
    - \_config.yml + about.md 수정
    - google analytics
    - google adsense
        - meta 태그 header.html에 추가
    - google site-verification
        - google search console > 접두어 > html 파일 다운로드 > root에 추가 커밋 푸시 > 확인
    - google search console
    	- sitemap.xml URL 검사(색인 생성 완료 후)
        - 색인생성 > Sitemaps에서 sitemap.xml 링크 추가
    - favicon 변경
    - [https://www.favicon-generator.org/](https://www.favicon-generator.org/)

## Git hooks 추가
새로운 글 등록시 메타 데이터 자동 업데이트를 위해 Git hooks 추가

```bash
# tool/pre-commit 파일을  .git/hooks 폴더로 복사
cp tool/pre-commit .git/hooks

# 필요시 권한 부여
chmod +x generateData.js
chmod +x tool/save-images.sh


# 메타 데이터 생성 위한 yamljs 설치
npm install yamljs
```
### npm command not found
1. [Node.js 설치](https://nodejs.org/ko/download)
2. `node -v`, `npm -v`로 버전 번호 출력 => 정상 설치 확인
3. 설치 후 다시 `npm install yamljs` 실행


## .vimrc 파일
- 메타데이터 updated 항목 자동 업데이트
- 새로운 문서 파일 기본 형식 입력 되도록
- 참고: [johngrib dotfiles](https://github.com/johngrib/dotfiles/blob/ecf130149d81a3e7e0f784adbb74abb7f2f01d99/nvim/config/set-vimwiki.vim#L63-L105
)

#### windows 경로 슬래시 문제
- windows에는 uuidgen.exe가 기본 설치가 되어있지 않음
- 나중에 윈도우 설정 파일 + 문제 해결 방법 작성


## 테마 설정
- [vimcolorschemes](https://vimcolorschemes.com/i/trending)
1. 원하는 테마 다운로드
2. color 폴더 안으로 colorscheme 파일 이동(gvim의 경우 `<사용자이름>\vimfiles\colors\`)
3-1. gvim 실행 후 `:colorscheme <테마이름>`
3-2. `\_vimrc`에 `colorshceme gruvbox` 추가

## 사용법
- 인덱스(root-index.md)에 폴더와 문서 적고 작성
- 수학 기호 작성시 문서 상단의 latex를 true로 변경

# ToDo
- 디자인 변경
- `save-images.sh` 변경 필요
- vimwiki 설정 내용 추가
- sitemap 추가

# timeline
- 251021: 디자인 변경
- 250716: 구글 맞춤 검색 코드 변경 & adsense
- 250602: 새 디자인 구상
- 250507: google search console에 sitemap 추가
- 250505: vimwiki 설정 내용 수정
- 250429: image 업로드 이슈

