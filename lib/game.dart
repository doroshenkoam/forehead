import 'dart:async';
import "dart:math";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forehead/const.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SelectThemeButton extends StatefulWidget {
  SelectThemeButton({required this.wordList});
  final List<String> wordList;

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
          MaterialPageRoute(
            builder: (context) => GamePage(
              wordList: widget.wordList,
            ),
          ),
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
  GamePage({required this.wordList});
  final List<String> wordList;

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

  var _wordCard = '';
  // набор слов (временное решение до перевода на базу)
  final _random = new Random();

  var _progress = 1.0;
  var _scoreSuccess = 0;
  var _scoreFail = 0;
  var _scoreStr = '0';

  final successDirectY = 5.0;
  final failDirectY = -5.0;

  @override
  void initState() {
    super.initState();

    // блокируем поворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // отслеживание датчика акселерометра
    // TODO: надо ли вырубать прослушивальщика?
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        if (event.x >= successDirectY) {
          // слово угадано
          _addScoreSuccess();
          _recalculateScore();
          _getWordCard();
        } else if (event.x <= failDirectY) {
          // слово не угадано
          _addScoreFail();
          _recalculateScore();
          _getWordCard();
        }
      });
    });

    _calculateTime();
    _startTimer();
    _getWordCard();
  }

  // _getWordCard получение новых карточек.
  // TODO: в будущем перевести на работу с базой.
  void _getWordCard() {
    setState(() {
      var _indexElemList = _random.nextInt(widget.wordList.length);

      _wordCard = widget.wordList[_random.nextInt(_indexElemList)];

      widget.wordList.remove(_indexElemList);
    });
  }

  // _recalculateScore пересчет очков.
  void _recalculateScore() {
    setState(() {
      _progress = _scoreSuccess / _scoreSuccess + _scoreFail;
      _timerStr = '$_progress';
    });
  }

  // _addScoreSuccess инкрементит счетчик удачных ответов.
  void _addScoreSuccess() {
    _scoreSuccess++;
  }

  // _addScoreFail инкрементит счетчик неудачных ответов.
  void _addScoreFail() {
    _scoreFail++;
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
    // разблокируем поворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(30),
              child: Text(
                _wordCard,
                style: styleTextWordCard,
              ),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.all(30),
                          child: CircularProgressIndicator(
                            value: _progress,
                            backgroundColor: Colors.red[700],
                            strokeWidth: 8,
                            color: Colors.amber,
                          ),
                        ),
                        Positioned(
                          child: Text(
                            _scoreStr,
                            style: styleTextWordCard,
                          ),
                        ),
                      ],
                    ),
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
          ],
        ),
      ),
    );
  }
}
