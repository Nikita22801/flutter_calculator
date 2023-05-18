import 'package:flutter/material.dart';

void main() => runApp(MyApp(calculatorWidget: CalculatorWidget()));

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Button Grid',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  final CalculatorWidget calculatorWidget;
  const MyApp({Key? key, required this.calculatorWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: calculatorWidget,
    );
  }
}

class CalculatorWidget extends StatefulWidget{
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _output = '';

  void _Calculate_btn() {
    String outputString = _output;
    while (outputString.contains('(')) {
      int openIndex = outputString.lastIndexOf('(');
      int closeIndex = outputString.indexOf(')', openIndex);
      String innerExpression = outputString.substring(openIndex + 1, closeIndex);
      String innerResult = evaluateExpression(innerExpression);
      outputString = outputString.replaceRange(openIndex, closeIndex + 1, innerResult);
    }
    setState(() {
      _output = evaluateExpression(outputString);
      if (_output.substring(_output.length - 2) == '.0'){
        _output= _output.substring(0, _output.length - 2);
      }
    });
  }

  String evaluateExpression(String expression) {
    double result = 0;
    List<String> operators = ['%', '/', '*', '-', '+'];
    List<String> tokens = expression.split(RegExp(r'([%/\*\-\+])'));
    List<String> ops = expression.split(RegExp(r'[0-9\.]+')).where((s) => s.isNotEmpty).toList();
    int i = 0;
    while (i < operators.length) {
      int j = 0;
      while (j < ops.length) {
        if (ops[j] == operators[i]) {
          double a = double.parse(tokens[j]);
          double b = double.parse(tokens[j + 1]);
          if (i == 0) {
            result = a % b;
          } else if (i == 1) {
            result = a / b;
          } else if (i == 2) {
            result = a * b;
          } else if (i == 3) {
            result = a - b;
          } else if (i == 4) {
            result = a + b;
          }
          tokens.replaceRange(j, j + 2, [result.toString()]);
          ops.removeAt(j);
          j--;
        }
        j++;
      }
      i++;
    }
    return tokens[0];
  }

  void _AC_btn() {
    setState(() {
      _output = '';
    });
  }

  // void _Bracket_btn() {
  //   setState(() {
  //     _output += _output.endsWith('(') ? ')' : '(';
  //   });
  // }

  void _Bracket_btn() {
    int openCount = 0;
    int closeCount = 0;

    // Подсчитываем количество открывающих и закрывающих скобок в строке
    for (int i = 0; i < _output.length; i++) {
      if (_output[i] == '(') {
        openCount++;
      } else if (_output[i] == ')') {
        closeCount++;
      }
    }

    // Определяем, нужно ли добавить открывающую или закрывающую скобку
    String bracket = openCount > closeCount ? ')' : '(';
    setState(() {
      _output += bracket;
    });
    }

  void _Percent_btn(){
    setState(() {
      _output += '%';
    });
  }

  void _Div_btn(){
    setState(() {
      _output += '/';
    });
  }

  void _Multi_btn(){
    setState(() {
      _output += '*';
    });
  }

  void _Minus_btn(){
    setState(() {
      _output += '-';
    });
  }

  void _Plus_btn(){
    setState(() {
      _output += '+';
    });
  }

  void _Dot_btn(){
    setState(() {
      _output += '.';
    });
  }

  void _Del_btn(){
    setState(() {
      _output = _output.length > 0 ? _output.substring(0, _output.length - 1) : _output;
    });
  }

  void _0_btn(){
    setState(() {
      _output += '0';
    });
  }

  void _1_btn(){
    setState(() {
      _output += '1';
    });
  }

  void _2_btn(){
    setState(() {
      _output += '2';
    });
  }

  void _3_btn(){
    setState(() {
      _output += '3';
    });
  }

  void _4_btn(){
    setState(() {
      _output += '4';
    });
  }

  void _5_btn(){
    setState(() {
      _output += '5';
    });
  }

  void _6_btn(){
    setState(() {
      _output += '6';
    });
  }

  void _7_btn(){
    setState(() {
      _output += '7';
    });
  }

  void _8_btn(){
    setState(() {
      _output += '8';
    });
  }

  void _9_btn(){
    setState(() {
      _output += '9';
    });
  }

  String cursor = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Button Grid'),
        ),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              ),
              child: Container(
                height: 250, // Устанавливаем высоту в 250 пикселей
                child: Center(
                  child: Text(
                    '$_output', // Задаем текст, который нужно отобразить внутри контейнера
                    style: TextStyle(fontSize: 40, color: Colors.white
                    ), // Настраиваем стиль текста по желанию
                  ),
                ),
                decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(20),
                color: Colors.white10,),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FloatingActionButton(
                    child: Text("AC", style: TextStyle(fontSize: 40),),
                    onPressed: _AC_btn,
                    backgroundColor: Color.fromARGB(255, 101, 76, 76),
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("( )", style: TextStyle(fontSize: 40),),
                    onPressed: _Bracket_btn,
                    backgroundColor: Color.fromARGB(148, 105, 101, 101),
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("%", style: TextStyle(fontSize: 40),),
                    onPressed: _Percent_btn,
                    backgroundColor: Color.fromARGB(148, 105, 101, 101),
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("/", style: TextStyle(fontSize: 40),),
                    onPressed: _Div_btn,
                    backgroundColor: Color.fromARGB(148, 105, 101, 101),
                  ),
                  width: 90,
                  height: 90,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FloatingActionButton(
                    child: Text("7", style: TextStyle(fontSize: 40),),
                    onPressed: _7_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("8", style: TextStyle(fontSize: 40),),
                    onPressed: _8_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("9", style: TextStyle(fontSize: 40),),
                    onPressed: _9_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Icon(Icons.clear), //Text("*", style: TextStyle(fontSize: 40),),
                    onPressed: _Multi_btn,
                    backgroundColor: Color.fromARGB(148, 105, 101, 101),
                  ),
                  width: 90,
                  height: 90,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FloatingActionButton(
                    child: Text("4", style: TextStyle(fontSize: 40),),
                    onPressed: _4_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("5", style: TextStyle(fontSize: 40),),
                    onPressed: _5_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("6", style: TextStyle(fontSize: 40),),
                    onPressed: _6_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("-", style: TextStyle(fontSize: 40),),
                    onPressed: _Minus_btn,
                    backgroundColor: Color.fromARGB(148, 105, 101, 101),
                  ),
                  width: 90,
                  height: 90,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FloatingActionButton(
                    child: Text("1", style: TextStyle(fontSize: 40),),
                    onPressed: _1_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("2", style: TextStyle(fontSize: 40),),
                    onPressed: _2_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("3", style: TextStyle(fontSize: 40),),
                    onPressed: _3_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("+", style: TextStyle(fontSize: 40),),
                    onPressed: _Plus_btn,
                    backgroundColor: Color.fromARGB(148, 105, 101, 101),
                  ),
                  width: 90,
                  height: 90,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FloatingActionButton(
                    child: Text("0", style: TextStyle(fontSize: 40),),
                    onPressed: _0_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text(".", style: TextStyle(fontSize: 40),),
                    onPressed: _Dot_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Icon(Icons.arrow_back_sharp),//Text("Del.", style: TextStyle(fontSize: 40),),
                    onPressed: _Del_btn,
                    backgroundColor: Colors.white10,
                  ),
                  width: 90,
                  height: 90,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Text("=", style: TextStyle(fontSize: 40),),
                    onPressed: _Calculate_btn,
                    backgroundColor: Color.fromARGB(255, 101, 76, 76),
                  ),
                  width: 90,
                  height: 90,
                ),
              ],
            ),
          ],
        ),
      );
  }
}
