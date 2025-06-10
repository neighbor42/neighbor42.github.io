---
layout  : wiki
title   : 유니코드 오류 처리 방안
summary : 
date    : 2025-06-10 16:23:11 +0900
updated : 2025-06-10 16:30:41 +0900
tag     : 
toc     : true
public  : true
parent  : [[/incident_archive]]
latex   : false
resource: 081E8F94-18D6-3A96-39C3-3394D4BD739E
---
* TOC
{:toc}


## LLaMa 모델 사용시, 데이터 내의 특수문자로 인한 잘못된 유니코드 생성 이슈 처리

- **원인**: 전각 문자가 포함된 특허 데이터를 LLAMA모델에 입력 시 발생
- **해결방안**: 전각문자 -> 반각문자로 변환 

```python
# 전각 -> 반각 변환
def full_to_half_unicode(s: str) -> str:
 result = []

 for ch in s:
 code = ord(ch)

 # 전각 문자 (U+FF01 ~ U+FF5E): 0xFEE0 빼기
 if 0xFF01 <= code <= 0xFF5E:
 result.append(chr(code - 0xFEE0))
 # 전각 특수문자 (U+FFE0 ~ U+FFE6)
 elif 0xFFE0 <= code <= 0xFFE6:
 result.append(chr(code - 0xFEE0))
 # 전각 공백 (U+3000) → 반각 공백 (U+0020)
 elif code == 0x3000:
 result.append(' ')
 else:
 result.append(ch)

 return ''.join(result)
```
