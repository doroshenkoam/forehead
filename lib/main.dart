import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forehead/const.dart';
import 'package:forehead/game.dart';
import 'package:forehead/list.dart';
import 'package:forehead/store.dart';

// TODO: надо написать тестов

void main() {
  runApp(ForeheadApp());
}

class ForeheadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forehead Application',
      theme: ThemeData.dark(),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPage createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StartPageBody(),
    );
  }
}

// StartPageBody разметка тела стартовой страницы.
class StartPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Row(
          children: <Widget>[
            Expanded(
                child: SelectThemeButton(
              wordList: WordsPackMustPopularRu.words,
              imagePath: 'assets/images/russian_1000.jpg',
              themeName: "ПОПУЛЯРНЫЕ",
            )),
            Expanded(
                child: SelectThemeButton(
              wordList: WordsPackDifferent.words,
              imagePath: 'assets/images/different.jpg',
              themeName: "МИКС",
            ))
          ],
        )),
        Expanded(
            child: Row(
          children: <Widget>[
            Expanded(
                child: SelectThemeButton(
              wordList: WordsPackMustPopularEng.words,
              imagePath: 'assets/images/english.jpg',
              themeName: "АНГЛИЙСКИЕ",
            )),
            Expanded(
                child: SelectThemeButton(
              wordList: WordsPackCountries.words,
              imagePath: 'assets/images/countries.jpg',
              themeName: "СТРАНЫ",
            ))
          ],
        )),
        // TODO: временно отключены
        // Expanded(
        //     child: Row(
        //   children: <Widget>[
        //     Expanded(child: SelectThemeButton()),
        //     Expanded(child: SelectThemeButton())
        //   ],
        // )),
        StoreInButton(),
      ],
    );
  }
}
