import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forehead/const.dart';
import 'dart:async';

Timer? _timer;
int _start = 120;

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
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => GamePage()),
        );

        // запускаем счетчик
        startTimer();
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

// startTimer старт таймера.
// TODO: таймер не работает... Нет обновлений, разобраться
void startTimer() {
  const oneSec = const Duration(seconds: 1);

  if (_timer != null) {
    _timer!.cancel();
    _start = 120;
  }


  _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start <= 0) {
            timer.cancel();
        } else {
            _start--;
        }
      },
  );
}

// dispose дроп таймера при выходе.
@override
void dispose() {
  if (_timer != null) {
    _timer!.cancel();
    _start = 120;
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePage createState() => _GamePage();
}

// GamePage страничка игры.
class _GamePage extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: colorBG,
        appBar: AppBar(
          centerTitle: true,
          title: Text("FOREHEAD", textAlign: TextAlign.center, style: styleTextAppBar,),
          backgroundColor: colorBGAppBar,
        ),
        body: Center(
          child: Text("$_start секунд", style: styleTextInStoreButton, textAlign: TextAlign.left,),
        ),
      ),
    );
  }
}
