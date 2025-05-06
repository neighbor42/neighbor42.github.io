---
layout  : wiki
title   : pipreqs로 깔끔한 requirements.txt 만들기
summary : 
date    : 2025-05-06 23:48:06 +0900
updated : 2025-05-06 23:53:29 +0900
tag     : pipreqs freeze
resource: A1/D86EF0-3593-4CC0-8199-98D78065A11C
toc     : true
public  : true
parent  : [[index]]
latex   : false
---
* TOC
{:toc}

## 일반적인 `pip freeze` 방식

```bash
pip freeze > requirements.txt
```

- 현재 가상환경에서 설치된 **모든 패키지 목록**을 `requirements.txt`로 저장한다
- 프로젝트와 무관한 패키지까지 모두 포함할 가능성이 있음(가상환경의 모든 패키지)


## `pipreqs` 방식
`pipreqs`는 **코드에 실제로 import된 모듈만 자동 탐지**해서 `requirements.txt`를 생성해준다

```bash
# 설치
pip install pipreqs

pipreqs ./ --force
```

- 현재 디렉토리(`./`) 기준으로 `requirements.txt` 생성
- `--force` 옵션은 기존 파일 덮어쓰기 허용
- 이 방식은 `import`된 라이브러리만 포함되므로 깔끔한 결과가 나옴
