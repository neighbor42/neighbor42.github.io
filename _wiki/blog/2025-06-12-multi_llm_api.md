---
layout  : wiki
title   : OpenAI API 자주 터지는 요즘
summary : 
date    : 2025-06-12 10:02:56 +0900
updated : 2025-06-12 10:12:19 +0900
tag     : api fallback
toc     : true
public  : true
parent  : [[/blog]]
latex   : false
resource: 9667C86E-39B6-54E0-0635-BABCCBD26E00
---
* TOC
{:toc}

## Openai API 문제
요즘 OpenAI API가 불안정하다고 한다.(다행인지 내가 사용할 때는 전혀 그런 점을 아직까지는 느끼지 못하고 있지만)  
GPT-4o 나오고 나서 트래픽이 왕창 늘었는지, `rate_limit`, `server_error` 같은 게 종종 튀어나온다는 증언들을 여기저기서 듣고 볼 수 있다.  
그래서 deepseek api 사용량이 많이 늘었다고 한다.


OpenAI 하나만 믿고 있다가 갑자기 터지면, 더군다나 현재 서비스 중인데 터지면...!  
찾아보니 몇개의 방어 전략이 있다

## 다중 API 백업 전략 
요즘은 모델도 멀티로 가야 되는 시대  
- 메인은 OpenAI로 쓰되, 실패 시 자동으로 다른 모델로 fallback 하도록 구성
- OpenAI, Claude, Gemini, Deepseek, mistral
API 하나 죽으면 다른 애가 받아준다.  
이걸 **자동화**해두면 최고


## API 체크 모듈 포함
- 주기적으로 각 LLM API 상태를 체크 > 실패율이 높은 API는 일시적으로 비활성화
- 서버 상태가 회복되면 다시 라우팅 허용


문서 자동 생성이나 채팅 기반 서비스는 모델 품질과 일관성이 중요하기에 fallback 모델들 간의 품질 차이도 고려해야 한다.

