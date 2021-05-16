# chapter 6. 내비게이션
> 화면 전환(내비게이션)
***
## 새로운 화면으로 이동
> 두 화면 내비게이션 하기
```
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First'),
      ),
      body: RaisedButton(
        child: Text('다음 페이지로'),
        onPressed: () {},
      ),
    );
  }
}
```
> 각 페이지를 위의 코드처럼 짠다. 
* ### push로 새로운 화면 호출 : Navigator 클래스의 push()메서드를 사용
    * builder : BuildContext 인스턴스를 인수로 받고 이동할 화면 클래스 인스턴스를 반환함.
    ```
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => [이동 페이지]),
    );
    ```
    > 두번째 페이지로 넘어갔을때 자동으로 돌아가는 아이콘이 표시된다.
* ### pop로 이전 화면으로 이동 : Navigator.pop()로 현재 화면을 종료휴 이전 화면으로 돌아간다.
    * Navigator.pop() : 인수로 context를 요한다.(반환 x)
* ### 새로운 화면에 값 전달하기 
    * 보낼때 : ```MaterialPageRoute(builder: (context) => [이동 페이지]),```에서 이동페이지의 매개변수에 객체를 보낸다.
    * 받을 때 : ```클래스명({@required 값});``` 형태로 받는다.
    > __@required__ 를 붙이면 필수 입력 인수이다.
* ### 이전 화면으로 데이터 돌려주기
    * 돌려줄 때 : ```Navigator.pop(context, 값)```형태로 돌려준다
    * 받을 때 : ```onPressed() async {}```으로 async 키워드를 더하고 ```final result = await Navigator...``` 형태로 받는다.
    > push()는 Future 타입의 반환 타입을 가짐. Future는 미래에 값이 들어올 것을 나타내는 클래스이다.
***
## routes를 활용한 내비게이션 
> 더 간결하고 체계적으로 내비게이션 구현
* ### routes 정의 : MaterialApp 클래스의 routes 프로퍼티에 정의 가능
    ```
    class MyApp..
    ...
    home: firstPage(), //첫 페이지를 시작 페이지로 지정
    routes : {
        '/first' : (context) => FirstPage(),
        '/second' : (context) => SecondPage(),
    },
    ```
    > 이제 기존의 __push()__ 대신 __pushNamed()__ 로 화면 내비게이션 실행 가능
***
## 내비게이션 동작 방식의 이해
> StatelessWidget 클래스와 StatefulWidget 클래스의 동작 방법 차이 이해하기
* __StatefulWidget__ 클래스는 기존의 메모리 화면을 모두 새로 그린다.(보여지지 않는 화면까지 그림-build 코드가 실행된다.) 그렇기에 앱 성능에 지장을 줄 만한 코드는 작성하면 안된다.
* ### initState, dispose : 생명주기 메서드(특정 타이밍에 실행되는 메서드)
    * initState() : 위젯이 생성될 때 호출된다.
    * dispose() : 위젯이 종료될 때 호출된다.