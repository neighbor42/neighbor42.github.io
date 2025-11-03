---
layout  : wiki
title   : AI Agent란
summary : 주체성, 독립성, 유연함
date    : 2025-11-04 08:14:15 +0900
updated : 2025-11-04 08:32:21 +0900
tags    : 
toc     : true
public  : true
parent  : [[index]]
latex   : false
resource: c2c940bf-054b-49c2-b8f0-882ca37a3193
---
* TOC
{:toc}

## AI agent의 특징
- 주변 환경을 인식하고
- 결정을 내리고
- 특정한 목표를 달성하기 위한 행동을 할 수 있다
- 그리고 위의 모든 것을 어느정도의 독립성을 가지고 수행한다

### 나의 에이전트
Jerry Maguire(영화) 같은 스포츠 에이전트, 또는 여행 에이전트처럼 AI agent도 그런 에이전트라고 생각하면 쉽다. 알아서 우리를 대신해서 거래를 하고, 적절한 비행기표를 찾아준다.

확정된 상황이 아니어도 관찰한 것을 토대로 선택지들을 고를 수 있는게 AI agent다. 지침을 그저 수행하는 것이 아니라, **무엇을 해야 하고, 어떻게 해야할지**를 파악한다.

### LLM
- 언어를 이해(?)하고
- 문제에 대해 생각하고
- 인간 같은 답변을 생성하고

방대한 텍스트 데이터로 학습한 모델들에 tool 사용과 행동할 수 있는 능력이 부여되면 AI agent 탄생이다. 언어 모델은 "뇌" 역할(정보 처리, 선택, 최선의 행동 결정)을 한다. 

### AI agent의 4가지 특성
1. 자율성, 또는 인간의 관여없이 결정을 독립적으로 할 수 있다
2. 반응, 변하는 환경과 새로운 정보에 맞춰 적절하게 반응한다
3. 주체성, 목표를 달성하기 위해 나서서 행동한다(수동적으로 자극 또는 입력이 있어야만 반응하는 것이 아니라)
4. 사회성, 다른 agent들과 또는 인간들과 어떤 형태로건 교류할 수 있는 능력


## AI Agent 작동방식
이제 agent loop에 대한 이해가 필요하다:
- 현재 상황 인식
- 다음 행동 생각
- 상세한 행동
- 행동의 결과 관찰
- 반복

위의 싸이클을 agent가 작업을 완료했다고 판단할 때까지(또는 인간) 계속 진행된다.

Agent는 정보 처리와 텍스트 생성에만 국한되어 있지 않다. 검색 엔진을 활용해 최신 정보를 찾을 수도 있고, 복잡한 계산, 코드 해석 등이 가능하다. 

**관찰과 적용/적응 하는 단계가 단순한 자동화 스크립트와 agent의 차이라고 볼 수 있다**



## Resources
- [bytebytego](https://blog.bytebytego.com/p/what-are-ai-agents?utm_source=post-email-title&publication_id=817132&post_id=177058290&utm_campaign=email-post-title&isFreemail=true&r=6nfrhf&triedRedirect=true&utm_medium=email)
