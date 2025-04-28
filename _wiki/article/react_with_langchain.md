---
layout  : wiki
title   : ReAct 논문 리딩
summary : 
date    : 2025-04-28 09:14:31 +0900
updated : 2025-04-28 09:26:13 +0900
tag     : ReAct, langchain
toc     : true
public  : true
parent  : [[article]]
latex   : false
resource: 086577D8-A282-AB24-D5BA-53339E38DFA9
---
* TOC
{:toc}

LLM을 사용할 때 가장 어려운 점은 모델이 우리가 원하는 방식으로 동작하게 만드는 것이다. 이는 오랫동안 연구되어 온 주제이기도 하다. 그 연구의 중심에 있던 핵심 논문 중 하나가 바로 ReAct다. 이름 그대로 REasoning + ACTing, 즉 '추론과 행동'에 관한 접근이다.


## Reasoning(추론)의 개념

Chain of Thought 논문에서 처음 등장한 개념이다. CoT는 모델이 답변을 내리기 전에 사고 과정을 거치게 하는 벙법인데, 이 방식은 모델 성능을 높이는 데 효과적이다. 이유는 다음과 같다.
- 사용자가 질문을 던지면, 모델은 답부터 내고, 이후에 그 답을 정당화하려는 설명을 한다.
- 때문에 초기에 잘못된 답을 내리면, 그 이후의 reasoning도 잘못될 확률이 높아진다.

하지만 사고를 먼저 하고, 그 다음에 답변을 내리게 하면 결과가 훨씬 좋앙진다. 생각하는 과정이 답변의 품질을 미리 준비시켜 주기 때문이다. 따라서 생각을 먼저 하고 답을 내리는 구조가 모델 성능을 높이는 핵심이다.


## Action(행동)의 개념
추론만이 아니라 모델이 직접 행동하게 하는 연구도 진행되어 왔다.
예를 들어,
- 검색 도구를 사용해 정보를 찾거나
- 계산기 사용
- 외부 환경과 상호작용해 결과 받아오기 등

이 두 가지를 통합한 방식이 바로 ReAct다.


# ReAct 구조
ReAct는 아래의 흐름을 따른다.
1. Thought(생각): 문제를 해결하기 위해 무엇을 해야 할지 생각
2. Action(행동): 도구를 이용한다(검색, 계산 등)
3. Observation(관찰): 행동 결과 받아오기
4. 필요하면 다시 thought > action > observation 반복
5. 최종 답변 출력(Finish)


# ReAct 프롬프트 작성 팁
중요한 점:
ReAct논문에 나온 예시(prmopt examples)를 그대로 복붙하지 않는다.
- 자신이 풀고자 하는 업무/도메인에 맞게 프롬프트를 수정해야 한다
- 예를 들어 금융 업무라면 모두(질문, thought, action, observation 예시 모두)를 금융 관련 내용으로 작성해야 한다.
기본 예시만 써도 모델이 어느 정도 잘 답변하지만, 정확도와 성능을 높이려면 반드시 자신의 분야에 맞게 튜닝해야 한다.
또한 사용하는 도구(tool) 종류도 상황에 맞게 다양하게 설정할 수 있다.

<br>

# 참고
- [ReAct 논문](https://arxiv.org/pdf/2210.03629)
- [ReAct Blog Post](https://research.google/blog/react-synergizing-reasoning-and-acting-in-language-models/)
- [Google프롬프트 엔지니어링 백서](https://www.kaggle.com/whitepaper-prompt-engineering)


