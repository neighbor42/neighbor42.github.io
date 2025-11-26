---
layout  : wiki
title   : uv 기본기
summary : uv로 넘어오면서 헷갈리는 부분들 기록
date    : 2025-10-27 17:58:45 +0900
updated : 2025-11-26 13:04:32 +0900
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
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

## 기본 명령어
```bash
# Python 설치
uv python install 3.13

# python 버전 확인
uv python list

```

### 프로젝트 설정
```bash
# 원하는 위치로 이동 후
uv init <프로젝트-이름>

# myproject 프로젝트를 python 3.12로 초기화
uv init myproject --python python3.12
```

### 가상환경
```bash
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

#### 개발용
```bash
# 개발용 의존성 설치시 끝에 `--dev` 추가
uv add pytest --dev

# 추가 옵션 붙는 경우
# pip 사용시
pip install "uvicorn[standard]"

# uv 버전
uv add uvicorn --extra standard

# 다른 프로젝트의 가상환경
# 만약 `uv sync`시 가상환경 없으면 자동 생성
uv sync  # `uv.lock` 파일 읽어 의존성 설치

# `dev` 의존성 제외 설치
uv sync --no-dev

```

#### 그 외 주요 명령어
- `uv init`: 파이썬 프로젝트 생성(pyproject.toml 파일 생성)
- `uv add`: 패키지 추가
- `uv remove`: 패키지 삭제
- `uv self update`: uv 업데이트

## Resources
- [uv github](https://github.com/astral-sh/uv)
- [chaechae.life](https://chaechae.life/blog/python-uv)
- [황금별.blog](https://www.0x00.kr/development/python/python-uv-simple-usage-and-example)
- [wikidocs](https://wikidocs.net/289878)
- [devocean](https://devocean.sk.com/blog/techBoardDetail.do?ID=167420&boardType=techBlog)
