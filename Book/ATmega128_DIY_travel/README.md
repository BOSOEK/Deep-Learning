# 마이크로컨트롤러 ATmega128 DLY 여행
> 책에서 회로 및 코드 구현은 Proteus 시뮬레이션을 통해 함.
## 목록
### [\[0\]. LED로 꾸미는 트리](#[0]-LED로-꾸미는-트리)
### [\[1\]. FND로 전화번호 표시기 만들기]()
### [\[2\]. 스위치로 1/100 스톱워치 만들기]()
### [\[3\]. 버저로 산토끼 노래 연주하기]()
### [\[4\]. 모터로 자연풍 선풍기 만들기]()
### [\[5\]. 센서를 이용하여 스마트 가로등과 소리 크기 표시기 만들기]()
### [\[6\]. UART 통신으로 암호문 보내기]()
***

## [0] LED로 꾸미는 트리
> ### 움직이는 LED 만들기
* ### 회로
![001](https://user-images.githubusercontent.com/68007145/110215477-5dbdc980-7eed-11eb-8189-7591e14fd63d.PNG)
```
// 왼쪽에서 오른쪽으로 불빛이 움직이는 코드
#include<avr/io.h>

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
