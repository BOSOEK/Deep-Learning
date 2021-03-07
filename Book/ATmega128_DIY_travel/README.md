# 마이크로컨트롤러 ATmega128 DLY 여행
> 책에서 회로 및 코드 구현은 Proteus 시뮬레이션을 통해 함.
## 목록
### [\[0\]. LED로 꾸미는 트리](#0_led로-꾸미는-트리)
### [\[1\]. FND로 전화번호 표시기 만들기](#1_FND로-전화번호-표시기-만들기)
### [\[2\]. 스위치로 1/100 스톱워치 만들기](#2_스위치로-1/100-스톱워치-만들기)
### [\[3\]. 버저로 산토끼 노래 연주하기]()
### [\[4\]. 모터로 자연풍 선풍기 만들기]()
### [\[5\]. 센서를 이용하여 스마트 가로등과 소리 크기 표시기 만들기]()
### [\[6\]. UART 통신으로 암호문 보내기]()
***

## 0_LED로 꾸미는 트리
> ### 움직이는 LED 만들기
* ### 회로
![001](https://user-images.githubusercontent.com/68007145/110215477-5dbdc980-7eed-11eb-8189-7591e14fd63d.PNG)

* ### 왼쪽에서 오른쪽으로 불빛이 움직이는 코드
```
#include<avr/io.h> 
#include<util/delay.h>  // _delay_ms 함수 사용을 위한 라이브러리

int main(void) {
  DDRA = 0xff;  //A 구역의 모든 포트를 출력으로 설정
  while(1) {    // LED 하나씩 켜지는 코드 실행
    PORTA = 0x80;
    _delay_ms(1000);
    PORTA = 0x40;
    _delay_ms(1000);
    PORTA = 0x20;
    _delay_ms(1000);
    PORTA = 0x10;
    _delay_ms(1000);
    PORTA = 0x08;
    _delay_ms(1000);
    PORTA = 0x04;
    _delay_ms(1000);
    PORTA = 0x02;
    _delay_ms(1000);
    PORTA = 0x01;
    _delay_ms(1000);
  }
  
  // 위 코드를 알고리즘으로 구현
  
  while(1) {
  // PORTA는 0x08, 0x04, 0x02 처럼 2로 나눠지거나 한칸씩 시프트 된다.
    for(i = 0x08;i>=0x01;i>>1) {
      PORTA = i;
      _delay_ms(1000);
    }
  }
}
```
* ### 크리스마스 트리 만들기(랜덤 불빛)
> 회로는 동일
```
#include <avr.io/h>
#include <stdlib.h>  // rand() 함수 라이브러리를 포함 할 수 있는 정보를 가진 헤더파일
#include <util.delay.h>

//rand() 함수에 상수가 아닌 인수를넣을 때는 
//delay.h 파일에 
//#define __DELAY_BACKWARD_COMPATIBLE__
//#define F_CPU 16000000UL
//위의 두 코드를 추가해야 오류가 안난다
//단 인수로 상수를 넣을때는 위 코드를 추가하면 안된다.

int main() {
  DDRA = 0xff;
  while(1) {
    PORTA = rand() % 256;  //0~255 난수 발생 하고 LED 표시
    _delay_ms(((rand()%50)+1)*100)  //0.1~5.0초까지 난수 시간 지연
  }
}
```
***
## 1_FND로 전화번호 표시기 만들기
* ### FND(Flexible Numeric Display) -> 7-segment와 동일
![150121032714](https://user-images.githubusercontent.com/68007145/110227161-b4042a00-7f38-11eb-9cd2-37735dbd9f24.png)
> 애노드 : LED의 화살표가 시작하는 지점
> 캐소드 : LED의 화살표가 끝나는 지점
> FND를 이용할 때는 공통 애노드 FND는 앞파벳 핀에 HIGH을 인가하면 LED가 OFF되고 캐소드는 핀에 HIGH를 인가하면 LED가 ON된다는 것이 중요!

* ### 트랜지스터
![201601081402268zzzzz849](https://user-images.githubusercontent.com/68007145/110227316-3fca8600-7f3a-11eb-9f6c-d942ecc30237.jpg)
> 트랜지스터는 전류를 증폭 혹은 감소 시킬 때 사용한다.
> FND의 8개의 핀의 전류가 ATmega가 버틸 수 있는 전류보다 커서 문제가 발생하기에 GND로 가는 전류를 줄이기 위해 사용한다.
> NPN 트랜지스터 기준으로 작동 방식은
> B-E간 전압이 0.7V 이상 순방향으로 걸리면 턴온 되었다 하며 C-E가 직접 연결 된다.
> B-E간 전압이 0.7V 이하면 턴오프 되었다 하며 C-E 연결이 끊긴다.
> 턴온시 B-E경로로 수 mA정도만 흘러도 C-E로는 수십배의 전류가 흐른다. 
> 즉 B에 HIGH을 인가하면 C-E가 연결되고 B가 LOW되면 C-E가 끊기는 조건부 스위치임.
> 우리가 B에 1을 주면 COM(공통회로)가 GND에 연결되며 다른 핀들의 ON/OFF여부에 따라 LED가 바뀐다(이때 전류 크기 문제 발생 X)
> 또한 B에 0을 주면 턴오프되어 COM이 회로 연결인 끊어지며 모든 LED에 전류가 흐를 수 없어 LED에 불 빛 안나옴
* ### FND에 7 출력하기
> 회로
![캡처](https://user-images.githubusercontent.com/68007145/110227540-c54f3580-7f3c-11eb-8ca9-e080cf571fd6.PNG)

> 코드
```
#include <avr/io.h>
#include <util/delay.h>
#include<stdlib.h>


int main()
 { 
   DDRD = 0xff;  //A 구역의 모든 포트를 출력으로 설정
   DDRG = 0x0f;
    PORTD = 0x07;
    PORTG=0x01;
 }
```

* ### 4-dight FND에 1234 출력하기
> 여러 dight의 FND는 하나씩 초당 30번 이상의 출력을 통해 잔상효과로 동시에 출력되는 것처럼 보인다.

> 때문에 핀은 LED의 8개에 각각 어떤 dight를 출력할 것인지 정하는 핀이 4개다.

> Proteus에서 1-dight FND는 캐소드 타입(각 비트에서 전류를 보냄)이지만 4-dight FND는 애노드 타입이다(각 비트에서 전류를 받음)

***

### 2_스위치로 1/100 스톱워치 만들기
