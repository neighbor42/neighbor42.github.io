---
layout  : wiki
title   : ch2 - supervised learning
summary : 
date    : 2025-05-19 15:24:48 +0900
updated : 2025-05-19 15:43:49 +0900
tag     : supervised 지도학습
resource: 15/5122B9-1EA3-452F-B2FC-B7BD7073EA45
toc     : true
public  : true
parent  : [[/study/understanding_deep_learning]]
latex   : false
---
* TOC
{:toc}

## 모델은 단순한 수학적 방정식이다
- 입력값이 이 방정식에 들어가고, 출력값이 계산된다
    - 이 과정을 추론(inference)라고 부른다
- 이 모델 방정식에는 parameter가 들어있다
    - 파라미터 값이 달라지면 출력도 달라진다
- 학습(train/learn)이란
    - **입력과 출력 사이의 관계를 잘 설명해주는 파라미터를 찾는 것**

## 지도학습
- 입력 `x`와 출력`y`는 정해진 크기의 벡터이며, 항목 순서도 동일하다
    - 이를 구조화된 데이터(structured/tabular data)라고 부른다
- 파라미터 φ(phi)
    - 파라미터의 선택이 입력과 출력 사이의 관계를 결정한다
    - `y = f[x, φ]`
- 오차 정도: 손실(loss) L
    - 파라미터 φ로 예측한 값이 실제 정답과 얼마나 다른지를 요약한 스칼라 값
    - φ의 최적값을 찾는 게 목표 > φ̂ (phi hat)
    - φ̂은 손실 함수를 최소화한 결과
        - hat 기호(^)는 최적화 결과를 의미함
- 훈련 후에는 테스트 데이터를 통해 일반화 성능(generalization)을 평가한다


## 1차원 선형 회귀 (1D linear regression) 모델
- 입력 `x`와 출력 `y` 사이의 관계를 직선으로 표현하는 모델

### Loss
- 각 파라미터 설정마다 모델이 데이터를 얼마나 잘 설명하는지를 숫자로 표현
    - 이게 바로 손실(loss)
- 손실이 낮을수록 모델 성능이 좋다
- 손실은 예측값과 실제값 아이의 차이(deviation)로 계산된다
    - 어느 방향인지는 중요하지 않기 때문에 제곱 연산을 사용한다
- L[φ]는 손실 함수(loss fuction) 또는 비용 함수(cost function)라고 한다
    - 목표는 L[φ]를 최소화하는 φ̂를 찾는 것

### Training
- 손실을 최소화하는 파라미터를 찾는 과정을
    - fitting, training이라고 부른다
- 기본 과정
    1. 파라미터를 랜덤하게 초기화
    2. 손실 함수의 곡면을 따라 바래 방향으로 점차 내려가기
        - 현재 위치에서 gradient(기울기)를 측정해서 가장 가파르게 내려가는 방향으로 한 걸음 이동
    3. 더 이상 내려갈 곳이 없을 때까지 반복

### Testing
- 새로운 테스트 데이터셋에서 손실을 계산해 현실 세계에서의 성능 평가
- 일반화(generalization)는 다음에 따라 달라진다:
    - 훈련 데이터가 얼마나 다양하고 대표성 있는지
    - 모델이 얼마나 표현력이 있는지
        - 너무 단순하면 관계를 잘 못 찾음 > underfitting(과소적합)
        - 너무 복잡하면 이상한 것 까지 외움 > overfitting(과적합)

## 정리
- 지도학습 모델은 `y = f[x, φ]`라는 수학적 함수
- 이 함수에서 관계를 결정짓는 건 φ (파라미터)
- 학습이란
    - 훈련 데이터셋 {x, y}에 대해 손실 함수 L[φ]를 정의하고
    - 이걸 최소화하는 최적의 φ̂를 찾는 것


## 추가 개념
- Loss function vs Cost function
    - loss function: 개별 데이터 포인트에 대한 손실
    - cost function: 전체 손실을 합친 값 (최적화 대상)
- Discriminative vs Generative
    - 판별 모델 (discriminative): `y = f[x]`
    - 입력 x로부터 출력 y를 예측
    - 생성 모델 (generative): `x = g[y]`
    - 출력 y를 기반으로 입력 x를 생성
