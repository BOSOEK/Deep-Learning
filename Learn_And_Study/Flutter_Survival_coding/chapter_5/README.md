# chapter 5. 기본 위젯 2
> 사용자와 상호 작용 및 애니메이션 구현 위젯을 알아본다.
## 입력용 위젯
> 입력용 위젯의 사용 방법을 알아본다.
* ### TextField : 글을 입력받는 위젯
    > ```InputDecoration``` 클래스와 함께 사용시 힌트 메시지 & 외각선 등의 꾸밈 효과를 추가할 수 있다.
    * labelText : 힌트 표현
    * border : 외각선 표시
    ```
    TextField(
        decoration : InputDecoration(
            border : outLineInputBorder(),
            labelText : '힌트'
        ),
    )
    ```
* ### Checkbox와 Switch : 체크박스, 라디오버튼, 스위치 표현 위젯
    > Checkbox와 Switch는 사용 방법이 동일하다
    * value : 상태를 나타내면 bool 타입의 변수가 필요하다
    * onChanged : 체크값이 변할 때마다 발생한다.
    * setState : 변숫값으로 UI를 다시 그린다.ㄴ
    ```
    var isChanked = false;

    Checkbox(
        value : isChanked,
        onChanged : (value) {
            setState(() {
                isChecked = value;
            }
        },
    ),

    Switch(
        value : isChanked,
        onChanged : (value) {
            setState(() {  // 
                isChecked = value;
            }
        },
    ),
    ```
* ### Radio와 RadioListtile : 선택 그룹중 하나를 선택하는 위젯
    __1. 그룹 항목을 열거형(enum)으로 정의한다.__
    __2. groupValue 프로퍼티에 열거형을로 정의한 타입의 변수를 지정하고, onChanged 이벤트에서 변경 값을 반영한다.__
    * ListTile은 동그라미만 터치 영역이지만 RadioListTile은 가로 전체가 터치 영역이다.
    ```
    enum Gender{MAN, WOMAN}
    Gender _gender = Gender.MAX;

    Listtile(
        title: Text('남자'),
        leading: Radio(
            value:Gender.Max,
            groupValue: _gender,
            onChanged:(value) {
                setState(() {
                    _gender = value;
                });
            },
        ),
    ),
    Listtile(
        title: Text('여자'),
        leading: Radio(
            value:Gender.WOMAN,
            groupValue: _gender,
            onChanged:(value) {
                setState(() {
                    _gender = value;
                });
            },
        ),
    ),
    ```

* ### DropDownButton : 여러 아이템중 하나를 고를 수 있는 콤보박스 형태의 위젯
    * value : 프로퍼티에 표시할 값 지정
    > items 프로퍼티에는 표시할 항목을 DropdownMenuItem 클래스의 인스턴스들을 담은 리스트로 지정해야 함.
    * 상태를 가지므로 StatefulWidget으로 작성
    ```
    //State 클래스 필드
    final _valueList = [각 값들];
    var _selectedValue = 처음 시작 값;
    
    DropdownButton(
        value = _selectedValue,
        items: _valueList.map(  //_valueList 리스트의 문자열 3개를 DropdownMEnuItem 인스턴스로 변환
            (value) {
                return DropdownMenuItem(
                    value : value,
                    child:Text(value)
                );
            },
        ).toList(),  // 다시 리스트로 변환
        onChanged: (value) {
            setState(() {
                _selectedValue = value;
            });
        },
    ),
    ```
## 다이얼로그 
> 사용자의 확인을 요구하는 메시지 표시 위젯
* ### AlertDialog
    > 머티리얼 디자인의 유저 확인용 다이얼로그
    * showDialog()함수의 builder 프로퍼티에 AlertDialog 클래스의 인스턴스 반환 함수를 작성한다.
    * barrierDismissible : 다이얼로그 바깥 부분을 터치해도 닫히게 할 것인지 정한다.
    ```
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('제목'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Alert dialog입니다.'),
                  Text('Ok를 눌러 닫습니다.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    ```
    __AlertDialog 클래스의 프러퍼티__
    * title : 제목 영역
    * content : 내용 영역
    * action : 버튼들을 정의한다.(버튼 클릭시 ```Navigator.of(context).pop```로 다이얼로그를 닫는다.)
* ### DatePicker : 날짜 선택 위젯
    > ```showDatePicker()``` 함수를 호출하면 달력이 표시되며 날짜를 선택하고  'OK' 버튼을 누르면 날짜를 반환
    * context : context를 인수로 전달
    * initialDate : 초기 선택값을 DateTime의 인스턴스로 정의
    * firstDate & lastDate : DatePicker에 표시할 날짜의 범위
    * builder : 테마 설정(theme 클래스로 다크 테마 적용 가능)
    > showDatePicker() 함수가 반환하는 Future<DateTime> 타입은 값이 결정될 때가지 코드가 블록되며 then() 메서드로 값이 결정되었을 시 처리 할 수 있다.
    ```
    Future<DateTime> selectedDate = showDatePicker(
        context: context,
        initialDate: DateTime.now(), //초기값
        firstDate: DateTime(2028),  //시작일 2028년 1월 1일
        lastDate: Datetime(2030),   //마지막일 2030년 1월 1일
        builder: (BuildContext context, Widget child) {
            return Theme(
                data: ThemeData.dark(),  //다크 모드 적용
                child: child,
            );
        },
    );
    ``` 
* ### TimePicker : 시간 선택 위젯
    > showTimePicker() 함수로 타임 피커를 표시 가능
    * initialTime : 초깃 값을 지정
    * context : context 필요, Future 타입으로 TimeOfDay(시간과 분)타입의 값을 반환
    ```
    Future<TimeOfDay> selectedTime = showTimePicker(
        initialtime: TimeOfDay.now(),  //현재 시간 설정
        context:context,
    );  //여기서 사용자가 시간을 선택할 때까지 코드가 블록됨
    ```
## 이벤트
> 이벤트를 기본 프로퍼티로 가지고 있지 않은 위젯에 이벤트 적용 위젯
* ### GestureDetector & InkWell : 이벤트 프로퍼티가 없는 위젯에 이벤트 적용시 사용하는 위젯
    > 두 위젯은 터치시 이벤트를 발생시킨다.
    * InkWell : 터치시 물결 효과가 나타남
    * gestureDetector : 효과 없음(터치 이벤트만 발생)
    ```
    GestureDetector(
        onTap: (){
            //클릭시 실행
        }
        child: 위젯,
    ),

    Inkwell(
        onTap: () {
            //클릭시 실행
        },
        child: 위젯,
    ),
    ```
## 애니메이션
> 애니메이션 위젯
* ### Hero : 화면 전환시 자연스럽게 연결되는 애니메이션 위젯
    > 애니메이션 효과의 대상이 되는 양쪽 화면의 위젯을 Hero 위젯으로 감싸고 tag프로퍼티를 동일하게 지정한다.
    * 그림을 클릭하면 화면이 전환되면서 그림이 커지는 애니메이션
    ```
    class HeroPage extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                    title: Text('Hero'),
                ),
                body: Center(
                    child: GestureDetector(
                    onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HeroDetailPage()),
                        );
                    },
                    child: Hero(
                        tag: 'image',  //태그 일치
                        child: Image.asset(
                        'assets/sample.jpg',
                        width: 100,
                        height: 100,
                        ),
                    ),
                    ),
                ),
            );
        }
    }

    class HeroDetailPage extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                    title: Text('Here Detail'),
                ),
                body: Hero(
                    tag: 'image',  //태그 일치
                    child: Image.asset('assets/sample.jpb'),
                ),
            );
        }
    }
    ```
* ### AnimatedContainer : 한 화면 안에서 setState() 함수로 화면을 새로 그릴대 변경된 프로퍼티에 의해 애니메이션 되도록 해줌.
    * duration : 필수이며 애니메이션 되는데 걸리는 시간을 정의
    * curve : 미리 정의된 애니메이션 효과
    ```
    AnimatedContainer(
        duration : Duration(seconds: 1),
        width: 100.0,
        height: 150.0,
        child : 위젯,
        curve: Curves.fastOutslowIn,
    ),
    ```
* ### SliverAppBar와 SliverFillRemaining : 화면 헤더를 동적으로 표현하는 위젯
    > __Scaffold__ 의 __appBar__ 를 지정하지 않고 body에 __CustomScrollView__ 의 인스턴스를 지정한다.
    > __CustomScrollView__ 의 silver 프로퍼티에 __SliverAppBar__ 와 __SliverFillRemaining__ 위젯을 설정한다.
    * SliverAppBar 프로퍼티
        * pinned : 축소 시 상단에 AppBar가 고정될 지 사라질 지 설정
        * expandedHeight : 확대될 때의 최대 높이를 지정
        * flexibleSpace : 확대/축소 되는 영역의 UI 작성
    > flexibleSpace : title과 background 프로퍼티로 AppBar영역이 확장되었을 때의 UI 작성
    * SliverFillRemaining : 스크롤 영역에 표시될 화면 정의, child 작성 내용 크기가 작아도 __SliverAppBar__ 부분이 축소될 때 딱 하나의 크기가 알아서 결정됨.
    ```
    Class SliverPage extends StateLessWidget {
        @override
        Widget build(BuildContext context) {
            return Scaffold(
                body : CustomScrollview(
                    slivers: <Widget> [
                        SliverAppBar (
                            ...
                        ),
                        SliverFillRemaining(
                            ...
    ```
* ### SliverAppBar & SliverList : 리스트 뷰를 사용해 Sliver효과를 주고 싶을 때 사용
    > 위의 코드에서 __SliverFillRemaining__ 대신 __SliverList__ 사용.
    * SliverList는 delegate 프로퍼티에 sliverChildListDelegate 클래스 인스턴스 지정하며 인수로 리스트 전달
    ```
    ..동일... ),
    SliverList(
        delegate : SliverChildListDelegate(리스트),
    ),
    ...
    ```
## 쿠퍼티노 디자인
> 머티리얼 : 안드로이드 적용 디자인 규칙
> 쿠퍼티노 : 아이폰 적용 디자인 규칙
* ### 쿠퍼티노 기본 UI : 쿠퍼티노는 __AppBar__ 대신 cupertinoNavigationBar를 사용하며, CupertinoSwitch, CupertinoButton 등을 사용함
    > __import 'package:flutter/cupertino.dart';__ 로 쿠퍼티노 위젯을 가져와야함
    * __CupertinoNavigationBar__ 는 머티리얼의 __AppBar__ 에 해당하며 leadding(왼쪽), middle(오른쪽, title), trailing(오른쪽) 프로퍼티들을 가진다.
    * __CupertinoSwitch__ 는 머티리얼의 스위치와 방법이 동일하다.
    * __CupertinoButton__ 는 RaisedButton에 대응하며 쿠퍼티노는 체크박스 & 라디오 버튼이 따로 없다.(글자만 있는 버튼이나 __borderRadius__ 로 외각선을 설정할 수 있다.)
* ### CupertinoAlertDialog : 쿠퍼티노 스타일의 AlertDialog다.
    > 기본적으로는 머티리얼의 __AlertDialog__ 와 같다.

    > 단, actions 프로퍼티에는 CupertinodialogAction 인스턴스를 갖는다.
    ```
    showDialog(
        context : context,
        builder: (context) => CupertinoalertDialog(
            title : 위젯,
            content : 위젯,
            actions : <Widget> [
                CupertinodialogAction(...),
                CupertinodialogAction(...),
            ],
        ),
    );
    ```
* ### CupertinoPicker : IOS에서 사용되는 피커로, 스크롤 하고 피커 바깥을 클릭하면 선택 값이 적용됨.
    ```
    showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
            height : 피커의 높이 지정,
            child: CupertinoPicker(
                children : <Widget>[..],
                itemExtent: //표시할 항목의 높이
                onSelectedItemChanged : (int value) {  //피커의 바깥 부분을 클릭시 피커가 닫히면서 호출
                    //선택된 항목의 인덱스 value를 처리
                },
            ),
        ),
    );
    ```