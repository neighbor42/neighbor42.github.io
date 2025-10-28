---
layout  : wiki
title   : uv 기본기
summary : uv로 넘어오면서 헷갈리는 부분들 기록
date    : 2025-10-27 17:58:45 +0900
updated : 2025-10-28 10:15:19 +0900
tags    : uv
toc     : true
public  : true
parent  : [[/package_manager]]
latex   : false
resource: 99e3d0fb-d2c8-4019-83e4-77ca3c66dc73
---
* TOC
{:toc}

특징: 아주, 아주, 아주 빠름

## Installation
```bash
# macOS & Linux - terminal
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

## 기본 명령어
```
# Python 설치
uv python install 3.13

# python 버전 확인
uv python list

```

### 프로젝트 설정
```
# 원하는 위치로 이동 후
uv init <프로젝트-이름>

# myproject 프로젝트를 python 3.12로 초기화
uv init myproject --python python3.12
```

### 가상환경
```
# 가상환경 생성
uv venv  # 기본
uv venv <가상환경 이름>  # 이름 구분하고 싶으면
# hello라는 이름의 python3.12 사용하는  가상환경 생성
uv venv hello --python python3.12 

# 기존 가상환경 삭제 후 다른 이름으로 새로 생성
uv venv --clear <새로운 가상환경 이름>
# world라는 이름의 새로운 가상환경 생성
uv venv --clear world --python3.13.9

# activate
# macOS & Linux
source .venv/bin/activate  # 기본 가상환경, 이름 없을 시
source world/bin/activate

# windows
.venv/Scripts/activate  # 기본 가상환경, 이름 없을 시
world/Scripts/activate

# 패키지 추가
uv add <패키지 이름>
uv add pandas
```

#### 그 외 주요 명령어
- `uv init`: 파이썬 프로젝트 생성(pyproject.toml 파일 생성)
- `uv add`: 패키지 추가
- `uv remove`: 패키지 삭제

## Resources
- [황금별.blog](https://www.0x00.kr/development/python/python-uv-simple-usage-and-example)
- [wikidocs](https://wikidocs.net/289878)
- [devocean](https://devocean.sk.com/blog/techBoardDetail.do?ID=167420&boardType=techBlog)
