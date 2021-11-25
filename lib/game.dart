import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forehead/const.dart';

class SelectThemeButton extends StatefulWidget {
  @override
  _SelectThemeButtonState createState() => _SelectThemeButtonState();
}

// SelectThemeButton кнопка темы.
class _SelectThemeButtonState extends State<SelectThemeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GamePage()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          // TODO: перевести на картинку для каждой темы
          color: colorSelectThemeButton,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePage createState() => _GamePage();
}

// GamePage страничка игры.
class _GamePage extends State<GamePage> {
  Timer? _timer;
  // TODO: в передаваемые параметры
  late int _start = 120;
  // TODO: в передаваемые параметры
  late int _baseStart = 120;
  var _timerStr = '';
  var _percent = 1.0;

  @override
  void initState() {
    super.initState();
    _calculateTime();
    _startTimer();
  }

  // _startTimer старт таймера.
  void _startTimer() {
    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start <= 0) {
          timer.cancel();
        } else {
          _start--;
          _calculateTime();
        }
      },
    );
  }

  // _calculateTime расчет строки таймера и обновление его отрисовки.
  void _calculateTime() {
    var minuteStr = (_start ~/ 60).toString().padLeft(2, '0');
    var secondStr = (_start % 60).toString().padLeft(2, '0');

    setState(() {
      _percent = _start / _baseStart;
      _timerStr = '$minuteStr:$secondStr';
    });
  }

  // dispose дроп таймера при выходе.
  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
      _start = 120;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: colorBG,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "FOREHEAD",
            textAlign: TextAlign.center,
            style: styleTextAppBar,
          ),
          backgroundColor: colorBGAppBar,
        ),
        body: Container(
          alignment: Alignment.bottomRight,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Stack(alignment: Alignment.center, children: [
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(30),
                child: CircularProgressIndicator(
                  value: _percent,
                  backgroundColor: Colors.red[700],
                  strokeWidth: 8,
                  color: Colors.amber,
                ),
              ),
              Positioned(
                child: Text(
                  _timerStr,
                  style: styleTextInStoreButton,
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
