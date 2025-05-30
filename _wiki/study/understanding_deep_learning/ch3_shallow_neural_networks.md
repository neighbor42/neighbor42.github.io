---
layout  : wiki
title   : shallow neural networks(얕은 신경망)
summary : 
date    : 2025-05-28 23:08:22 +0900
updated : 2025-05-28 23:09:29 +0900
tag     : shallow networks activation
resource: 35/82D614-848C-4D21-AF15-878F8DC779D6
toc     : true
public  : true
parent  : [[/study/understanding_deep_learning]]
latex   : false
---
* TOC
{:toc}

# 

## jargons

| 용어                        | 한국어              | 의미                                                           |
| input layer                 | 입력층              | 입력값이 들어오는 층                                           |
| hidden layer                | 은닉층, 히든 레이어 | 입력과 출력 사이의 중간 처리 층(ReLU 등의 활성화 함수 적용)    |
| output layer                | 출력층              | 모델의 최종 예측 결과가 나오는 층                              |
| weight                      | 가중치              | 한 노드에서 다른 노드로의 연결 강도(선형 계수)                 |
| bias                        | 편향                | 각 유닛에 더해지는 상수 값, y절편 역할                         |
| activation                  | 활성화              | ReLU 등                                                        |
| pre-activation              | 활성화 전 값        | ReLU 등 활성화 적용하기 전의 선형 계산 결과                    |
| neuron / hidden unit        | 뉴런/은닉 유닛      | 히든 레이어를 구성하는 개별 단위. 하나의 선형+비선형 처리 유닛 |
| Multi Layer Perceptron(MLP) | 다층 퍼셉트론       | 하나 이상의 은닉층을 가진 신경망의 명칭                        |
| shallow neural network      |                     | 은닉층이 하나뿐인 신경망                                       |
| deep neural network         |                     | 은닉층이 여러 개인 신경망                                      |
| feed-forward network        |                     | 데이터가 순방향으로만 흐르는 구조(순환 없음)                   |
| fully connected network     |                     | 각 층의 모든 노드가 다음 층의 모든 노드와 연결됨               |



## Shallow Neural networks
> 얕은 신경망은 구간별 선형 함수(piecewise linear functions)를 표현하며, 다차원 입력과 출력 사이의 임의로 복잡한 관계도 근사할 수 있을 만큼 표현력이 충분하다.

1. shallow neural networks(얕은 신경망)
    - 하나의 히든 레이어를 가진 신경망
    - 입력 > 히든 유닛 > 출력
2. piecewise linear functions를 표현
    - ReLU와 같은 활성화 함수 덕분에, 전체 출력은 여러 선형 조각이 이어진 형태가 됨
    - 각 조각(region)은 히든 유닛의 활성화 여부에 따라 달라짐
    - 따라서 결과적으로는 "조각난 직선들"을 연결한 복잡한 형태의 함수가 됨
3. 복잡한 관계도 근사할 수 있을 만큼 표현력이 충분하다
    - 이론적으로는 아무리 복잡한 함수라도, 충분히 많은 히든 유닛이 있으면 얕은 신경망이 흉내낼 수 있음
    - 보편 근사 정리, Universal Approximation Theorem
    - 예를 들어, 손글씨 인식처럼 복잡한 입력-출력 관계도 근사 가능
5. 다차원 입력과 출력
    - 입력이 벡터일 수도 있고, 출력도 벡터일 수 있음
    - 예를 들어, 이미지(픽세 배열)을 받아서 [0-9]중 하나의 숫자로 분류

## ReLU 활성화 함수
- ReLU(z)=max(0,z)
- 음수는 0으로 잘리고, 양수는 그대로 통

![relu-activation-function](https://i.imgur.com/hTPxpCO.png)

1. inactive (비활성)
    - ReLU 함수는 음수를 받으면 출력을 0으로 자른다.
    - 해당 유닛의 출력은 0, 학습이나 예측에 아무 기여도 하지 않음
    - "죽은 상태"로 간주됨
    - 이 유닛을 비활성/inactive 상태라 부른다
2. active (활성)
    - ReLU에게 입력되는 값이 0 이상이면, 그대로 출력된다 > 정보 전달됨
    - 이 경우 해당 유닛은 계산에 실제 영향을 미침
    - 이때만 학습 및 출력 계산에 참여하는 셈
    - 최종 출력에 영향을 미치므로 active(활성)상태라고 부름

## Resources
- [UDL 공식 사이트 인터랙티브 버전 figure](https://udlbook.github.io/udlfigures/)

