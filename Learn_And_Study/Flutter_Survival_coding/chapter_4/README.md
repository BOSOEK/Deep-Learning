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
    