import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmiMain(),
    );
  }
}

//첫번째 페이지
// 사용자의 입력 & 검증 페이지
class BmiMain extends StatefulWidget {
  @override
  _BmiMainState createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>(); //폼의 상태 얻기 위한 키

  final _heightController = TextEditingController(); //키를 가져오는 컨트롤러 인스턴스
  final _weightController = TextEditingController(); // 몸무게를 가져오는 컨트롤러 인스턴스

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose(); // 컨트롤러 인스턴스는 화면 종료시 반드시 Dispose()로 해제해야 한다
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          //폼
          key: _formKey, //키할당
          child: Column(
            children: <Widget>[
              //키 입력 필드
              TextFormField(
                decoration: InputDecoration(
                  //외각선이 있고 힌트로 '키'를 표시
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                controller: _heightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                    return '키를 입력하세요';
                  }
                  return null;
                }, //숫자만 입력 가능
              ),
              SizedBox(
                height: 16,
              ),
              //몸무게 입력 필드
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                controller: _weightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return '몸무게를 입력하세요.';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {
                    //폼에 입력된 값 검증
                    if (_formKey.currentState.validate()) {
                      //키와 몸무게가 검증되었다면 화면 이동
                      //검증시 처리
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BmiResult(
                                double.parse(_heightController.text.trim()),
                                double.parse(_weightController.text.trim()))),
                      );
                    }
                  },
                  child: Text('결과'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//두번째 페이지
// 결과 출력
class BmiResult extends StatelessWidget {
  final double height; //키
  final double weight; //몸무게

  BmiResult(this.height, this.weight); //키와 몸무게를 받는 생성자

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height / 100) * (height / 100));
    print('bmi : $bmi');
    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              //TODO : 수정할 부분(글자)
              _calcBmi(bmi), //계산 결과에 따른 결과 문자열
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 16,
            ),
            _buildIcon(bmi),
          ],
        ),
      ),
    );
  }

  String _calcBmi(double bmi) {
    var result = '저체중';
    if (bmi >= 35) {
      result = '고도 비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi >= 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }
    return result;
  }

  Widget _buildIcon(double bmi) {
    if (bmi >= 23) {
      return Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 100,
      );
    } else if (bmi >= 18.5) {
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,
      );
    } else {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.orange,
        size: 100,
      );
    }
  }
}
