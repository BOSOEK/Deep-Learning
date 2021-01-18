# Deep_Learning_from_Scratch
> 밑바닥부터 시작하는 딥러닝

## 목록

### [1.파이썬](#1.-파이썬)
### [2. 퍼셉트론]()
### [3. 신경망]()
### [4. 신경망 학습]()
### [5. 오차역전파법]()
### [6. 학습 관련 기술들]()
### [7. 합성곱 신경망(CNN)]()
### [8. 딥러닝]()
### [9. 기타]()

***

## 1. 파이썬
* ### 넘파이(Numpy)
> 딥러닝 구현시 필요한 배열이나 행렬 계산을 넘파이의 배열 클래스 numpy.array의 메서드로 편하게 구현할 수 있다.
 ***
> ### 넘파이 배열 생성
> * 넘파이 배열 생성시에는 np.array() 메서드 사용하여 numpy.ndarray를 반환받는다
```
import numpy as np
x = np.array([1.0, 2.0, 3.0]) # [1., 2., 3.] 출력, 타입은 'numpy.ndarray'이다
```
> ### 넘파이 산술 연산
> * 넘파이 배열의 산술 연산은 각 원소에 대해서 행해진다(원소 수나 배열의 차원이 다르면 오류가 발생한다)
```
x = np.array([1.0, 2.0, 3.0])
y = np.array([2.0, 4.0, 6.0])
x + y # array([3.0, 6.0, 9.0])
```
> ### 넘파이 N차원 배열
> * 배열.shape : 각 차원의 크기를 보여줌
> * 배열.dtype : 배열의 타입
> **수학에서는 1차원 배열은 벡터(vector), 2차원 배열은 행렬(matrix), 벡터와 행렬을 일반화한 것을 텐서(tensor)라고 한다**
> ### 브로드 캐스트
> * 넘파이에서 형상(배열 수, 차원)이 다른 배열끼리의 계산 시 자동으로 형상을 맞춰 계산되는 기능을 __브로드 캐스트__라고 한다.
```
N = np.array([1, 2, 3, 4])
N * 10 # np.array([10, 20, 30, 40]) # 스칼라 값(수치 하나)인 10이 2X2로 확대됐다.
 
A = np.array([1, 2], [3, 4])
B = np.array([10, 20])
A * B # array([10, 40], [30, 80]) #B가 자동으로 2차원 배열 A와 똑같은 형상으로 변환됐다
```
> ### 원소 접근
> * 배열.flatten() : 배열을 1차원 배열로 변환(평탄화)
```
X = np.array([51, 55], [14, 19], [0, 4])
X.flatten() # [51, 55, 14, 19, 0, 4]
 
X[np.array([0, 2, 4])] # array([51, 55, 19]) # 인덱스가 0, 2, 4인 원소 얻기
```
* ### matplotlib
> 딥러닝 실험시 필요한 그래프와 데이터 시각화를 그려주는 라이브러리
***
> ### 그래프 그리기
> * 그래프는 matplotlib의 pyplot 모듈을 사용한다
```
import numpy as np
import matplotlib.pyplot as plt

x = np.arange(0, 6, 0.1) # 0~6까지 0.1 간격으로 생성
y = np.sin(x)

plt.plot(x, y) # 그래프 작성
plt.show() # 그래프 출력
```
> ### pyplot의 기능
```
x = np.arange(0, 6, 0.1)
y1 = np.sin(x)
y2 = np.cos(x)

# 그래프 그리기
plt.plot(x, y1, label="sin") #레이블에 'sin'이라고 표시
plt.plot(x, y2, linestyle="--", label="cos") # cos 함수는 점선으로 그리고 레이블에 'cos'이라고 표시
plt.xlabel("x") # x축 이름
plt.ylabel("y") # y축 이름
plt.title("sin & cos") # 제목
plt.legend()
plt.show()
```
> # 이미지 표시
> * 이미지를 읽어들일 때는 matplotlib.image 모듈의 imread() 메서드를 사용하고 표시할때는 imshow()를 사용한다
```
import matplotlib.pyplot as plt
from matplotlib.image import imread

img = imread("이미지 경로")
plt.imshow(img)
plt.show()
```
## 2. 퍼셉트론(인공 뉴런, 단순 퍼셉트론)
> 퍼셉트론 알고리즘은 1957년 프랑크 로젠블라트가 고안한 신경망(딥러닝)의 기원이 되는 알고리즘으로 다수의 신호를 입력받아 하나의 신호를 출력하며 전류와 비슷하지만 퍼셉트론 신호는 흐른다(1)/안흐른다(0)의 두가지 값만 가진다.
![2-1입력이2개인퍼셉트론](https://user-images.githubusercontent.com/68007145/104921566-d9ff5a80-59dc-11eb-8c38-f5f812dc8a45.png)
***

## 3. 신경망

## 4. 신경망 학습

## 5. 오차역전파법

## 6. 학습 관련 기술들

## 7. 합성곱 신경망(CNN)

## 8. 딥러닝
