import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  bool inDone;
  String title;

  Todo(this.title, {this.inDone = false});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '할일 관리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _items = <Todo>[]; //할 일 목록을 저장할 리스트

  var _todoController = TextEditingController(); //할일 문자열 조작을 위한 컨트롤러

  @override
  void dispose() {
    _todoController.dispose(); //사용후 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('남은 할 일'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _todoController,
                    ),
                  ),
                  RaisedButton(
                    child: Text('추가'),
                    onPressed: () => _addTodo(Todo(_todoController.text)),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('todo').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final documents = snapshot.data.documents;
                  return Expanded(
                    child: ListView(
                      children: documents
                          .map((todo) => _buildItemWidget(todo))
                          .toList(),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final todo = Todo(doc['title'], inDone: doc['inDone']);
    return ListTile(
      onTap: () => _toggleTodo(todo), //Todo : 클릭시 완료 / 취소되도록 수정
      title: Text(
        todo.title,
        style: todo.inDone //완료일때 스타일 적용
            ? TextStyle(
                decoration: TextDecoration.lineThrough, //취소선
                fontStyle: FontStyle.italic, //이태릭체
              )
            : null, //아무 스타일도 적용 안함
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(todo), //todo : 쓰레기통 클릭 시 삭제되도록 수정
      ),
    );
  }

  void _addTodo(Todo todo) {
    // 할일 추가 메서드
    setState(() {
      _items.add(todo);
      _todoController.text = ''; //할일 입력 필드를 비움
    });
  }

  void _deleteTodo(Todo todo) {
    // 할일 삭제 메서드
    setState(() {
      _items.remove(todo);
    });
  }

  void _toggleTodo(Todo todo) {
    // 할일 완료 / 미완료 메서드
    setState(() {
      todo.inDone = !todo.inDone;
    });
  }
}
