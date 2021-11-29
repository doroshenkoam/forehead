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
              wordList: new List<String>.from(widget.wordList),
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
  StreamSubscription? _accel;
  Timer? _timer;
  // TODO: в передаваемые параметры.
  late int _restOfTime = 120;
  // TODO: в передаваемые параметры
  late int _gameSessionTime = 120;
  var _timerStr = '';
  var _percent = 1.0;

  var _wordCard = '';
  final _random = new Random();

  var _progress = 1.0;
  var _scoreSuccess = 0;
  var _scoreFail = 0;
  var _scoreStr = '0';

  final baseDirect = 0.0;
  final rotateDirectY = 4.0;

  @override
  void initState() {
    super.initState();

    // блокируем поворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // TODO: промежуточный виджет с отсчетом.

    // отслеживание датчика акселерометра
    if (_accel == null) {
      _accel = gyroscopeEvents.listen((GyroscopeEvent event) {
        setState(() {
          if (baseDirect - rotateDirectY >= event.y) {
            // слово угадано
            _addScoreSuccess();
            _recalculateScore();
            _getWordCard();
          } else if (baseDirect + rotateDirectY <= event.y) {
            // слово не угадано
            _addScoreFail();
            _recalculateScore();
            _getWordCard();
          }
        });
      });
    } else {
      _accel!.resume();
    }

    _calculateTime();
    _startTimer();
    _getWordCard();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // _getWordCard получение новых карточек.
  // Если таймер закончился, засчитаем последнее слово в копилку и все.
  // TODO: в будущем перевести на работу с базой.
  void _getWordCard() {
    setState(() {
      if (_restOfTime == 0) {
        // в подсчете очков сравнение будет идти именно с этой константой
        _wordCard = gameFinishText;
        return;
      }

      if (widget.wordList.length == 0) {
        // TODO: пока заглушка, после будем предлагать купить новые слова.
        _wordCard = gameFinishText;
        return;
      }

      var _indexElemList = _random.nextInt(widget.wordList.length);

      _wordCard = widget.wordList[_indexElemList];

      widget.wordList.removeAt(_indexElemList);
    });
  }

  // _recalculateScore пересчет очков.
  void _recalculateScore() {
    setState(() {
      if (_wordCard != gameFinishText) {
        if (_scoreFail != 0) {
          _progress = _scoreSuccess / (_scoreFail + _scoreSuccess);
        }

        _scoreStr = '$_scoreSuccess';
      }
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
        if (_restOfTime <= 0) {
          timer.cancel();
        } else {
          _restOfTime--;
          _calculateTime();
        }
      },
    );
  }

  // _calculateTime расчет строки таймера и обновление его отрисовки.
  void _calculateTime() {
    var minuteStr = (_restOfTime ~/ 60).toString().padLeft(2, '0');
    var secondStr = (_restOfTime % 60).toString().padLeft(2, '0');

    setState(() {
      _percent = _restOfTime / _gameSessionTime;
      _timerStr = '$minuteStr:$secondStr';
    });
  }

  // dispose дроп таймера при выходе.
  @override
  void dispose() {
    super.dispose();

    // разблокируем поворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (_timer != null) {
      _timer!.cancel();
    }
    if (_accel != null) {
      _accel!.cancel();
    }

    _restOfTime = 120;
    _wordCard = '';
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
