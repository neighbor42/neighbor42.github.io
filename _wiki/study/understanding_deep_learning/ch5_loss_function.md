---
layout  : wiki
title   : ch5 - loss function(손실 함수)
summary : 
date    : 2025-06-02 16:10:26 +0900
updated : 2025-06-03 00:18:32 +0900
tag     : loss function
resource: 7F/BC1F34-4BB7-4304-9C62-30FCE4C7DE83
toc     : true
public  : true
parent  : [[/study/understanding_deep_learning]]
latex   : false
---
* TOC
{:toc}

## jargon

## 손실 함수는 왜 필요한지??
- 모델을 만들고나면 이 모델이 얼마나 잘 예측하는지, 혹은 얼마나 엉터리인지 평가할 성적표가 필요하다.  
- 그게 바로 손실 함수(loss function) 또는 비용 함수(cost function)

모델이 예측한 값(f[xᵢ, ϕ])과 실제 정답(yᵢ) 사이가 얼마나 다른지 숫자로 알려준다. 그리고 학습의 목표는 이 손실값을 최소로 만드는 모델 파라미터(ϕ)를 찾는 거다.  

