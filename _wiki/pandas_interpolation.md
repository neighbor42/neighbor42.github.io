---
layout  : wiki
title   : pandas interpolation(보간법)\: 결측치 처리
summary : 
date    : 2025-05-09 21:09:43 +0900
updated : 2025-05-09 21:50:33 +0900
tag     : interpolation pandas nan
resource: 18/96E368-B307-470B-9C47-E92273BA20D9
toc     : true
public  : true
parent  : [[index]]
latex   : false
---
* TOC
{:toc}

# interpolation(보간법)
- 데이터 사이의 새로운 포인트를 추정하는 방법
- 쉽게 말해 점과 점 사이를 채우는 작업이라고 생각하면 

# 보간법 종류
## Linear interpolation(선형 보간법)
- 가장 단순하고 직관적인 보간법
    - 두 개의 알려진 데이터 포인트를 직선으로 연결

```
# (x1, y1), (x2, y2)는 알고 있는 두 데이터 포인트

y = y_1 + \frac{(x - x_1)(y_2 - y_1)}{x_2 - x_1}

```
- (x1, y1)과 (x2, y2)는 알고있는 데이터 포인트
- 장점: 구현이 간단하고 계산 비용이 낮음
- 복잡한 데이터에서는 정확도가 떨어질 수 있음


# 코드
## Pandas를 활용한 데이터프레임 결측치 보간
- pandas는 `interpolate()` 메서드를 통해 데이터프레임의 결측치를 쉽게 보간할 수 있다

```python
import pandas as pd
import numpy as pd

# 결측치 포함된 데이터프레임 생성
data = {
    "x1": [1, np.nan, 3, 4, np.nan, np.nan, np.nan, 8, 9],
    "y1": [1, 2, 3, 4, np.nan, np.nan, np.nan, 8, 9],
    "x2": [1, 2, 3, 4, np.nan, np.nan, np.nan, 8, 9],
    "y2": [1, 2, 3, 4, np.nan, np.nan, np.nan, 8, 9]
}

df = pd.DataFrame(data)
print("원본 데이터프레임:")
print(df)
```

```
# 실행결과
원본 데이터프레임:
    x1   y1   x2   y2
0  1.0  1.0  1.0  1.0
1  NaN  2.0  2.0  2.0
2  3.0  3.0  3.0  3.0
3  4.0  4.0  4.0  4.0
4  NaN  NaN  NaN  NaN
5  NaN  NaN  NaN  NaN
6  NaN  NaN  NaN  NaN
7  8.0  8.0  8.0  8.0
8  9.0  9.0  9.0  9.0
```

```python
# 선형 보간법을 사용한 결측치 처리
df_interpolated = df.interpolate()
print("\n보간 후 데이터프레임:")
print(df_interpolated)
```

```
보간 후 데이터프레임:
    x1   y1   x2   y2
0  1.0  1.0  1.0  1.0
1  2.0  2.0  2.0  2.0
2  3.0  3.0  3.0  3.0
3  4.0  4.0  4.0  4.0
4  5.0  5.0  5.0  5.0
5  6.0  6.0  6.0  6.0
6  7.0  7.0  7.0  7.0
7  8.0  8.0  8.0  8.0
8  9.0  9.0  9.0  9.0
```

- `interpolate()` 메서드는 기본적으로 선형보간법을 사용해 인덱스를 기준으로 결측치를 채운 걸 확인할 수 있다

```python
# 다양한 보간법
methods = ['linear', 'quadratic', 'cubic', 'spline', 'polynomial', 'nearest']
results = {}

for method in methods:
    try:
        # method가 'spline'이나 'polynomial'인 경우 추가 매개변수 필요
        if method in ['spline', 'polynomial']:
            results[method] = df.interpolate(method=method, order=2)
        else:
            results[method] = df.interpolate(method=method)
    except:
        print(f"{method} 방법은 현재 데이터에 적용할 수 없습니다.")
```
- linear: 기본값, 선형 보간법
- time: 시계열 데이터에 적합, 시간 인덱스를 사용한다
- index: 인덱스의 실제 간격을 고려한 선형 보간법
- values: 값의 순서대로 보간(인덱스 무시)
- nearest: 가장 가까운 값으로 채운다
- zero, slinear, quadratic, cubic: 각각 0차, 1차, 2차, 3차 스플라인 보간법
- barycentric, polynomial: 다항식 보간법의 변형들
- spline: 스프라인 보간법으로 order 매개변수로 차수를 설정
- piecewise_polynomial: 구간별 다항식 보간법
- from_derivatives: 미분값을 고려한 보간법


