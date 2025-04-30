---
layout  : wiki
title   : ReAct 프롬프팅 리뷰
summary : 
date    : 2025-04-28 09:14:31 +0900
updated : 2025-04-30 10:39:17 +0900
tag     : ReAct, langchain
toc     : true
public  : true
parent  : [[/article]]
latex   : false
resource: 086577D8-A282-AB24-D5BA-53339E38DFA9
---
* TOC
{:toc}


LLM을 사용할 때 가장 어려운 점은 모델이 우리가 원하는 방식으로 동작하게 만드는 것이다. 이는 오랫동안 연구되어 온 주제이기도 하다. 그 연구의 중심에 있던 핵심 논문 중 하나가 바로 ReAct다. 이름 그대로 REasoning + ACTing, 즉 '추론과 행동'에 관한 접근이다.


# Reasoning(추론)의 개념
![reason_only](https://i.imgur.com/IHiBGFl.png)

Chain of Thought 논문에서 처음 등장한 개념이다. CoT는 모델이 답변을 내리기 전에 사고 과정을 거치게 하는 벙법인데, 이 방식은 모델 성능을 높이는 데 효과적이다. 이유는 다음과 같다.
- 사용자가 질문을 던지면, 모델은 답부터 내고, 이후에 그 답을 정당화하려는 설명을 한다.
- 때문에 초기에 잘못된 답을 내리면, 그 이후의 reasoning도 잘못될 확률이 높아진다.

하지만 사고를 먼저 하고, 그 다음에 답변을 내리게 하면 결과가 훨씬 좋앙진다. 생각하는 과정이 답변의 품질을 미리 준비시켜 주기 때문이다. 따라서 생각을 먼저 하고 답을 내리는 구조가 모델 성능을 높이는 핵심이다.
<br>
<br>
<br>


# Action(행동)의 개념
![act_only](https://i.imgur.com/0EPtF3C.png)
추론만이 아니라 모델이 직접 행동하게 하는 연구도 진행되어 왔다.

모델이 실제 환경에서 어떤 행동(action)을 수행하게 하고 그 행동의 결과를 관찰(observation)하여 다시 모델에 반영하는 방식이다. 이러한 접근의 대표적인 예가 SayCan 모델이다

## SayCan
- Google Deepmin에서 발표한 시스템
	- 핵심 아이디어: 모델이 말하는 것(Say)이 아니라, 실제로 할 수 있는 것(Can)을 기준으로 삼게 하자.

**작동방식**
1. 모델이 사용자 요청을 자연어로 이해한다
	- 컵을 집어 들고 테이블 위에 올려놔
2. 모델이 가능한 행동(action) 후보들을 만들어 낸다
	- 컵을 집는다, 걸어간다, 올려놓는다 같은 구체적인 행동 단위
3. 각 행동 후보에 대해 "로봇의 정책"이 이 행동을 성공적으로 수행 할 수 있는 확률 평가
4. 성공 확률이 높은 행동만 골라서 순차적으로 실행
언어로 생각하고 > 물리적으로 가능한 것만 선택하는 방식


목표: LLM이 무조건 명령을 수행하는 게 아니라, 현실적으로 가능한 행동만 수행하게 함<br>
구성: 명령 해석 + 행동 평가 모델(Can 여부 판단)<br>
응용 분야: 로봇 조작, 물리 환경과 상호작용하는 시스템<br>


예시
- 사용자 입력: 책을 선반에 올려줘 >
- LLM: 책을 집는다 > 선반 쪽으로 이동 > 선반에 책을 놓는다 (행동 시퀀스 제안)
- 정책 모델: "지금 내 위치에선 책을 집을 수 없다"(불가) 판단 > 다른 경로 찾거나 실패 보고
결국 실제 가능한 행동만을 골라서 실행



# ReAct 구조

![image](https://i.imgur.com/UAeaozx.png)

여기서 ReAct가 등장한다.

ReAct는 앞서 말한 두 가지 기법, 추론(reasoning)과 행동(action)을 함께 결합해 훨씬 더 나은 결과를 얻을 수 있다는 것을 보여준다.

ReAct는 아래의 흐름을 따른다.
- 먼저 추론을 수행한다
- 그 다음 행동을 취하는데, 예를 들어 랭체인 같은 프레임워크에서는 도구(tool)을 사용한다
- 그리고 그 행동의 결과를 다시 모델에 입력한다
	- 이렇게 얻은 관찰 결과를 활용해 추론을 더욱 정교하게 다듬는 것이 가능해진다

이 과정을 통해 단순히 한 번의 CoT로 끝내는 것이 아니라,

여러 번의 사고와 행동을 반복해 다단계로 문제를 해결할 수 있다.

## HotPotQA 데이터셋 사용 예시

![hotpot_qa_original_prompt](https://i.imgur.com/Xra5YCX.png)

만약 질문을 바로 던지면, 기본적으로 "1986"이라는 답변만 얻는다.



![hotpot_qa_reason_only_prompt](https://i.imgur.com/Aof4FJE.png)

만약 추론만 한다면
- 어떤 형태로든 CoT 프롬프트를 넣게 되고
- 그러면 답변에 도달하기 전에 어느 정도의 추론 과정이 포함된 결과를 얻게 된다.

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


