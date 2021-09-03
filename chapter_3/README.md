# chapter3 프로젝트 및 엡 구조 이해하기
> 프로젝트의 구조와 앱 구조를 알아보며 간단한 실습을 한다.
### 프로젝트 구성 폴더
* .idea : 개발 도구에 필요한 설정
* android : 안드로이드 네이티브 코드를 작성하는 부분
* build : 빌드시 생성되는 파일
* ios : IOS 네이티브 코드를 작성하는 부분
* lib : 다트 코드를 작성하는 부분
* test : 테스트 코드를 작성하는 부분
### 프로젝트 구성 파일
* .gitignore : Git 설정 파일. 버전 관리시 무사할 파일 규칙 작성
* .metadata : 프로젝트가 관리하는 파일. __임의로 수정하지 않습니다.__
* .packages : 각종 패이키 정보. __임의로 수정하지 않는다.__
* flutter_app.iml : 개발 도구에 필요한 설정 파일. __임의로 수정하지 않는다.__
* pubspec.lock : 패키지 매니저가 이용하는 파일. __임의로 수정하지 않는다.__
* pubspec.yaml : 패키지 매니저가 이용하는 파일
* README.md : 프로젝트 설명을 작성하는 파일

*** 
### main.dart 파일 정리
```
// 플러터는 화면을 그리는 모든 디자인 요소를 위젯이라고 한다
import 'package:flutter/material.dart'; //머티리얼 디자인 위젯 사용 가능

//앱 시작 부분
void main() {
  //앱의 시작점
  runApp(MyApp());
}

// 시작 클래스. 머티리얼 디자인 앱 생성
class MyApp extends StatelessWidget {
  //StatelessWidget : 상태가 없는 위젯을 정의하는데 사용(한번 그려진 후 다시 그려지지 않음)
  //StatelessWidget 클래스는 build() 메서드를 가지며 build()는 위젯을 생성할 때
  //호출하고, 실제로 그릴 위젯을 작성해 반홤함
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //build가 반환하는 MaterialApp 클랫
      title: 'Flutter Demo', //제목
      theme: ThemeData(
        // 테마
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '니가 김치를 알어?'), //표시할 화면의 인스턴스
    );
  }
}

// 시작 클래스가 실제로 표시하는 클래스. 카운터 앱 화면
class MyHomePage extends StatefulWidget {
  // StatefulWidget : 상태가 있는 위젯을 정의할때 사용
  MyHomePage({Key key, this.title}) : super(key: key); //
  // MyHomePage 생성자는 키와 타이틀을 받아 부모 클래스의 생성자에게 키를 전달함
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
  //StatefulWidget이 생성될때 한번만 실행됨
}

// 위 MyHomepage 클래스의 상태를 나타내는 State 클래스
class _MyHomePageState extends State<MyHomePage> {
  // 상태 클래스 : State 클래스를 상속받은 클래스
  // 상태 클래스는 변경 가능한 상태를 프로퍼티 변수로 표현, 나중에 화면을 다시 그림

  int _counter = 0; //화면에 표시할 상탯값인 카운터 숫자

  // counter 변수를 1증가 시키고 화면을 다시 그리는 메서드
  void _incrementCounter() {
    //사용자가 +버튼을 누르면 이 메서드가 호출됨
    setState(() {
      //화면을 다시 그리도록 하는 함수. StatefulWidget만 가능
      _counter++;
    });
  }

  // 화면에 UI를 그리는 메서드. 그려질 위젯을 반환
  @override
  Widget build(BuildContext context) {
    // _MyHomePageState 클래스의 상태에 따라 화면에 그려질 코드를 작성함
    return Scaffold(
      //머티리얼 디자인 기본 뼈대 위젯
      appBar: AppBar(
        //AppBar : 머티리얼 디자인 앱에서 상단 제목과 메뉴를 표시하는 영역
        title: Text(widget.title), //
      ),
      body: Center(
        //표시할 내용
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter', //_counter 변수를 표시
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, //클릭 시 _incrementCounter() 메서드 실행
        tooltip: 'Increment', //버튼을 길게 터치시 표시할 글자 지정
        child: Icon(Icons.add), //+모양을 표현
      ),
    );
  }
}
```