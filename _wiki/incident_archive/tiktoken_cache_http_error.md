---
layout  : wiki
title   : 오프라인 환경에서 tiktoken(cl100k_base) 사용하기
summary : 
date    : 2025-06-17 10:06:34 +0900
updated : 2025-06-17 16:15:08 +0900
tag     : tiktoken encoding offline
toc     : true
public  : true
parent  : [[/incident_archive]]
latex   : false
resource: D1D75FEF-E3D4-F05A-075B-CCDB12B0C1D5
---
* TOC
{:toc}

`tiktoken` 라이브러리는 텍스트를 토큰으로 분할하고 그 개수를 세는 데 필수적인 도구이다. 하지만 인터넷이 차단된 오프라인 환경(내부망, 보안 서버 등)에서 사용하려고 하면 예상치 못한 `HTTPConnectionPool` 또는 `MaxRetryError`은 네트워크 오류와 마주하게 된다.


![error](https://i.imgur.com/rtzi4Wy.png)

## 해결
- 인터넷 되는 환경에서 tiktoken 캐시 파일 미리 준비 > 오프라인 환경으로 옮겨 그 위치를 tiktoken에게 알리기(`TIKTOKEN_CACHE_DIR` 환경 변수 설정해 간단히 해결 가능)


1. 파일 다운로드: 인터넷이 되는 PC에서 [cl100k_base.tiktoken 파일](https://openaipublic.blob.core.windows.net/encodings/cl100k_base.tiktoken) 다운로드
2. `9b5ad71b2ce5302211f9c61530b329a4922fc6a4`로 파일 이름 변경
3. tiktoken 사용하는 곳에 아래 코드 추가

```python
import os

tiktoken_cache_dir = "<tiktoken cache 위치>"
os.environ["TIKTOKEN_CACHE_DIR"] = tiktoken_cache_dir
```


## 단계별 가이드
### 1단계: 인코더 다운로드 URL 확보
- 오프라인에서 사용할 인코더(cl100k_base)의 원본 파일(.tiktoken) 다운로드 URL을 알아내야는데
- 이 URL은 `tiktoken` 라이브러리 소스 코드 내에 하등코딩 되어 있다
- `inspect` 모듈을 사용하면 라이브러리를 직접 열지 않고도 해당 URL을 찾을 수 있다
- https://openaipublic.blob.core.windows.net/encodings/cl100k_base.tiktoken
	- 25년 6월 기


```python
import tiktoken_ext.openai_public
import inspect

# cl100k_base 인코더준를 로드하는 함수의 소스 코드 확인
print(inspect.getsource(tiktoken_ext.openai_public.cl100k_base))

# 코드 실행하면 아래와 같은 함수 정의를 볼 수 있는데, `load_tiktoken_bpe`의 함수의 인자로 전달되는 URL이 필요한 주소다
>>>
def cl100k_base():
	mergeable_ranks = load_tiktoken_bpe(
		"https://openaipublic.blob.core.windows.net/encodings/cl100k_base.tiktoken")
```

### 캐시 키(파일 이름)
- tiktoken은 다운로드 URL을 `SHA1` 알고리즘으로 hash한 값을 파일명으로 사용해 캐시를 관리한다
- 따라서 동일한 방식으로 파일명을 변경해주어야 한다.

```python
import hashlib

# 1단계에서 찾은 blob URL 사용
blob_url = "https://openaipublic.blob.core.windows.net/encodings/cl100k_base.tiktoken"

# URL을 SHA1으로 해시해 캐시 키 생성
cache_key = hashlib.sha1(blob_url.encode()).hexdigest()

print(f"생성된 캐시 키 (변경할 파일명): {cache_key}")

>>>
생성된 캐시 키 (변경할 파일명): 9b5ad71b2ce5302211f9c61530b329a4922fc6a4
```
cl100k_base.tiktoken 파일을 9b5ad71b2ce5302211f9c61530b329a4922fc6a4 으로 변경


### 3단계: tiktoken 캐시 설정해서 사용하기
- os.environ을 사용해 TIKTOKEN_CACHE_DIR 환경 변수 설정
- 이 때 파일이 위치한 폴더의 경로를 지정할 것!
```python
import os

# 캐시 설정
```python
tiktoken_cache_dir = "path_to_folder_containing_tiktoken_file"
os.environ["TIKTOKEN_CACHE_DIR"] = tiktoken_cache_dir

# tiktoken 사용하기
encoding = tiktoken.get_encoding("cl100k_base")
encoding.encode("Hello, world from offline environment!")
```
이제 인터넷 연결 없이도 tiktoken을 자유롭게 사용할 수 있다



## 오프라인 환경 오류 발생 원인
- tiktoken은 특정 인코딩 모델(cl100k_base 같은)을 처음 사용할 때, 해당 모델에 필요한 `.bpe` 파일을 인터넷에서 다운로드해 로컬 캐시 디렉토리에 저장
- 인터넷이 연결된 환경에서는 이 과정이 자동으로 진행됨
- 하지만 인터넷 연결이 없는 오프라인 환경에서는 이 다운로드 과정이 실패, 서버에 연결할 수 없다는 HTTP 관련 오류 발생

## 출처
- [stackoverflow](https://stackoverflow.com/questions/76106366/how-to-use-tiktoken-in-offline-mode-computer)
