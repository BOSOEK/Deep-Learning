# chapter4 기본 위젯 1
> 자주 사용하는 위젯(화면을 구성하는 컴포넌트)을 알아본다.

## 화면 배치에 쓰는 기본 위젯
> 화면을 구성하고 배치하는 데 뼈대가 되는 위젯

* ### Container : 다양한 프로퍼티를 가지고 있는 가장 기본적인 위젯.
    * color : 색
    * width : 가로 길이
    * height : 세로 길이
    * padding : 안쪽 여백
    * margin : 바깥쪽 여백
    * 또 다른 위젯도 사용 가능
    > 예시 코드
    ```
    Container (
        color : Colors.red,
        width: 100,
        height : 100,
        padding: const EdgeInsets.all(8.0)
        margin : const EdgeInsets.all(8.0)
    )
    ```
* ### Column : 수직 방향으로 위젯들이 배치되는 위젯
    > children 프로퍼티에 여러 위젯 리스트를 지정 가능하다.
    ```
    Column(
        children: <Widget> [
            위젯,
            위젯,
            위젯,
        ]
    )
    ```
* ### Row : 수평 방향으로 위젯들이 배치되는 위젯
    > children 프로퍼티에 여러 위젯을 나열한다.

    > Row, Column처럼 방향성이 있는 위젯은 __mainAxis__ 와 __crossAxis__ 관련 프로퍼티가 있다.
    * mainAxis : 위젯의 기본 방향(Row : 오른쪽, Column : 아래쪽)
    * crossAxis : 기본 방향의 반대 방향(Row : 아래쪽, Column : 오른쪽)
    > 프로퍼티 정리
    * mainAxisSizek : 크기 조절
        > max : 최대 크기, 남은 공간을 모두 차지한다.
        > min : 최소 크기, 포함된 콘텐츠의 크기만큼만 차지한다.
    * mainAxisAlignment(가로) & crossAxisAlignment(세로) : 가로 & 세로 방향 정렬
        > center : 가운데 정렬
        > start : 위 & 왼쪽 정렬
        > end : 아래 & 오른쪽 정렬
        > 그외 : spaceEvenly, spaceBetween, spaceAround

    ```
    Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            위젯,
            위젯,
            위젯,
        ]
    )
    ```
* ### Stack : children에 나열된 여러 위젯을 겹치게 만듦
    > 사진 위에 글 표시, 화면 위에 로딩 표시 등에 사용됨.

    > children에 정의된 리스트들 중 먼저 작성한 위젯이 가장 아래에 위치, 나중에 작성한 위젯이 위쪽에 위치한다.
    ```
    Stack(
        children: <Widget>[
            위젯,  //가장 아래에 위치
            위젯,
            위젯,  //가장 위에 위치
        ]
    )
    ```
* ### SingleChildScrollView : 하나의 자식을 포함하는 스크롤 가능한 위젯
    > Column은 표시할 위젯만큼만 가로 길이를 가진다.
    
    > 하지만 ListBody는 스크롤 가능 영역이 가로로 꽌 차서 사용자가 스크롤 하기 더 쉽다.
    ```
    SingleChildScrollView(
        child: ListBody(
            children : 위젯
        )
    )
    ```
* ### ListView, ListTile
    > ListView : 리스트를 표시하는 위젯
    > ListTile : 리스트 아이템을 쉽게 작성할수 있는 위젯
    * leading : 왼쪽에 위치하며 글 & 아이콘 배치 가능
    * title : 가운데에 위치하며 글 & 아이콘 배치 가능
    * trailing : 오른쪽위 위치하며 글 & 아이콘 배치 가능
    __ListView와 ListTile을 조합하면 표준적인 리스트를 쉽게 만들 수 있다.__
    ```
    ListView(
        scrollDirection : Axis.vertical,
        chilren : <Widget> [
            ListTile(
                leading: Icon(Icons.home),
                title : Text('Home'),
                trailing: Icon(Icons.navigate_next),
            ),
        ],
    ),
    ```
* ### GridView : 열 수를 지정하여 그리드 형태로 표시하는 위젯
    > GridView.count() : 간단하게 그리드를 작성하게 해준다.
    * crossAxisCount : 프로퍼티에 열 수를 지정할 수 있다.
    ```
    gridView.count(
        crossAxisCount: 열수
        children: <Widget> [
            위젯,
            위젯,
            위젯
        ],
    ),
    ```
* ### PageView : 여러 페이지를 좌우로 슬라이드 하여 넘길 수 있는 위젯
    > children 프로퍼티에 각 화면 위젯을 준비해 지정하면 화면을 좌우로 슬라이드 할 수 있다.

    > __Tab__ 과 연동하지 않으면 좌우로 슬라이드 가능한지를 모를 수 도 있어서 단독으로 사용 안한다.
    ```
    PageView(
        children: <Widget>[
            위젯, 
            위젯,
            위젯,
        ],
    ),
    ```
* ### AppBar, TabBar, Tab, TabBarView : 페이지와 탭이 연동되는 화면 구성
    * 예시 코드
    ```
    class MyHomePage extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
            return DefaultTabController(  //Scaffold를 감싸고
            length: 3,                    // 탭 수 지정
            child: Scaffold(
                appBar: AppBar(
                title: Text('Tab'),
                bottom: TabBar(   // Scaffold의 bottom 프로퍼티에 TabBar 지정
                    tabs: <Widget>[   //tabs 프로퍼티에 Tab의 리스트 지정
                    Tab(icon: Icon(Icons.tag_faces)),
                    Tab(text: '메뉴'),
                    Tab(icon: Icon(Icons.info), text: '메뉴'),
                    ],
                ),
                ),
                body: TabBarView(//Scaffold의 body 프로퍼티에는 TabBarView 배치
                children: <Widget>[    //children 프로퍼티에 표시할 화면 배치
                Container(                            
                    color: Colors.yellow,
                ),
                Container(
                    color: Colors.orange,
                ),
                Container(
                    color: Colors.red,
                ),
                ]),
            ),
            );
        }
    }
    ```
* ### BottomNavigationBar : 하단에 2~5개의 탭 메뉴를 구성할 수 있는 위젯으로 각 탭을 클릭하여 화면을 전활 할 때 사용한다.
    > Scaffold의 프로퍼티 중 bottomNavigationBar를 정의하고 items프로퍼티에 BottomNavigationBarItem위젯을 나열한다.
    * icon : 보여지는 아이콘 이미지
    * title : 보여지는 간단한 글꼴
    ```
    Scaffold(
        bottomNavigationBar: BottomNavigationBar(items:[
            BottomNavigationBarItem(
                icon : 아이콘
                title: 타이틀 글
            ),
            BottomNavigationBarItem(
                icon : 아이콘
                title: 타이틀 글
            ),
        ]),
    );
    ```
***
## 위치, 정렬, 크기를 위한 위젯
> 위젯을 배치후 위젯 크기, 위치, 크기를 보조하는 위젯

* ### Center : 중앙으로 정렬 시키는 위젯
    > child 프로퍼티에 중앙에 배치할 위젯을 설정한다.
    ```
    Center(
        child: 위젯,
    ),
    ```
* ### Padding : 안쪽 여백을 표현하는 위젯
    > 안쪽 여백은 __EdgeInsets__ 클래스로 padding 프로퍼티에 값을 지정한다.

    > 앞에 const를 붙이면 컴파일 타임에 상수로 정의 되어 다시 사용되는 부분이 있을 때 메모리 값을 재사용 한다.(이득)
    * EdgeInsets.all(값) : 네 방향 모두 같은 값을 지정한다.
    * EdgeInsets.only({left:왼쪽, top:위, right:오른쪽, bottom:아래쪽}) : 원하는 방향만 값을 지정한다. (지정하지 않으면 0으로 지정됨)
    * EdgeInsets.fromLTRB(왼쪽, 위, 오른쪽, 아래) : 네 방향의 값을 각각 지정한다.
    ```
    Padding(
        padding : const EdgeInsets.all(40.0),
        child: Container(
            color: Colors.red,
        ),
    ),
    ```
* ### Align : 자식 위젯의 정렬 방향을 정할 수 있는 위젯.
    > 자식 위젯을 정렬 하기 위해 alignment 프로퍼티에 정렬하고자 하는 방향을 정의한다.
    * bottomLeft : 하단 왼쪽
    * bottomCenter : 하단 중앙
    * bottomRight : 하단 오른쪽
    * centerLeft : 중단 왼쪽
    * center : 중단 중앙
    * centerRight : 중단 오른쪽
    * topLeft : 상단 왼쪽
    * topCenter : 상단 중앙
    * topRight : 상단 오른쪽
    ```
    Align(
        alignment : Alignment.bottomRight,
        child: 위젯,
    ),
    ```
* ### Expanded : 자식 위젯을 최대한으로 확장시키는 위젯
    * flex : 정숫값으로 비율을 지정할 수 있으며 기본 값은 1이다.
    ```
    Column(
        children: <Widget>[
            Expanded(
                flex : 비율
                child : 위젯
            ),
            Expanded(
                flex : 비율
                child : 위젯
            ),
        ],
    ),
    ```
* ### SizedBox : 위젯을 특정 크기로 만들때 사용한다.
    * width : 가로 길이(double 타입)
    * height : 세로 길이(double 타입)
    * SizedBox를 child 없이 쓰면 __여백 표시__
    ```
    SizedBox(
        width: 가로길이
        height : 세로길이
        child : 위젯
    )
    ```
* ### Card : 카드 형태의 모양을 제공하는 위젯
    > 기본적으로 크기는 0이지만 자식 위젯의 크기에 따라 크기가 결정된다.
    * elevation : 그림자의 깊이를 조정한다.
    * shape : 카드 모양을 변경하는 방법을 제공한다.
    ```
    Card(
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 그림자 깊이(실수값),
        child : 위젯,
    ),
    ```
    * __RoundedRectangleBorder__ : __borderRadius__ 프로퍼티에 __BorderRadius.circular()__ 메서드를 지정해 모서리 둥근 정도를 실수값으로 조절한다.
***
## 버튼 계열 위젯
> 여러 종류의 벼튼 위젯
* ### RaisedButton & Flatbutton 
    > RaisedButton : 입체감을 가지는 버튼
    > Flatbutton : 평평한 버튼
    * child : 글이나 이미지 등의 버튼에 들어갈 내용
    * color : 버튼 색깔
    * onPressed : 버튼 클릭시 실행될 함수(null 지정시 버튼 클릭 안됨(비활성화))
    ```
    RaisedButton(
        child: Text(글),
        color : Colors.orange,
        onPressed: () {
            // 실행 될 코드
        },
    ),
    ```
* ### IconButton : 아이콘을 표시하는 버튼 위젯
    > 아이콘의 크기나 색을 지정할 수 있다.

    > 자식 위젯을 포함 할 수 없어서 child 프로퍼티가 없다.
    * icon : 아이콘 입력
    * iconSize : 아이콘 크기 지정
    ```
    IconButton (
        icon : Icon(아이콘 이미지),
        color : Colors.red,
        iconSize : 아이콘 크기
        onPressed:(){},
    ),
    ```
* ### FloatingActionButton : 입체감 있는 둥근 버틋 위젯
    ```
    FloatingActionbutton(
        child: Icon(아이콘),
        onPressed : (){},
    ),
    ```
***
## 화면 표시용 위젯
* ### Text : 글자 표시 위젯.
    > 첫번째 인수에 문자열을 지정(필수 파라미터)하여 Text('글자') 형태로 사용한다.

    > style 프로퍼티에 textStyle 클래스의 인스턴스를 지정하여 글자 스타일을 변경한다.
    * fontSize : 글자 크기(double)
    * fontStyle : 글씨체
    * fontWeight : 글자 굵기
    * color : 글자 색
    * letterSpacing : 자간(글자 사이의 간격)
    ```
    Text(
        '글자',
        style:TextStyle(
            fontSize : 40.0,
            fontStyle: FontStyle.italic,
            fontWeight : fontWeight.bold,
            color : Coloors.red,
            letterSpacing:4.0,
        ),
    ),
    ```
* ### Image : 이미지 표시 위젯
    * 인터넷 이미지 가져오기
        ```Image.network('이미지URL')```
    * 이미지 파일을 이용해 직접 표시
        > 1. pubspec.yaml 파일의 ```flutter:```항목 아래에 이미지 저장 폴더명을 지정한다.
        ```
        //예시
        flutter:
            폴더명:
                -폴더명/
        ```
        > 2. 터미널에서 __flutter packages get__ 명령으로 이미지 파일에 접근할 수 있게 한다.
        > 3. ```Image.asset('이미지저장폴더명/이미지파일')```형태로 이미지를 불러온다.
* ### Icon : 아이콘 표시 위젯
    > Icons 클래스에 정의된 디자인용 기본 아이콘들을 사용한다.
    ```
    Icon(
        Icons.기본 아이콘,
        color:Colors.색,
        size:크기,
    ),
    ```
* ### Progress : 로딩중에 사용자에게 보여주는 용도의 위젯
    * CircularProgressIndicator() : 둥근 형태의 프로그레스 바
    * LinearProgressIndicator() : 선 형태의 프로그레스 바
* ### CircleAvatar : 프로필 화면등에 사용되는 원형 위젯
    > 표시하는 이미지 파일을 원형으로 만들어줌.
    * 이미지 파일을 이용해 직접 표시
        ```
        CircleAvatar(
            child:Icon(이미지 파일),
        ),
        ```
    * 인터넷 이미지 표시
        ``` 
        CircleAvatar(
            backgroundImage: NetworkImage([이미지 URL]),
        ),
        ```