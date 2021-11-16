import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forehead/const.dart';
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
        title: Text("FOREHEAD", textAlign: TextAlign.center, style: styleTextAppBar,),
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
      children: <Widget> [
        Expanded(child: Row(
          children: <Widget> [Expanded(child: SelectThemeButton()), Expanded(child: SelectThemeButton())],
        )),
        Expanded(child: Row(
          children: <Widget> [Expanded(child: SelectThemeButton()), Expanded(child: SelectThemeButton())],
        )),
        Expanded(child: Row(
          children: <Widget> [Expanded(child: SelectThemeButton()), Expanded(child: SelectThemeButton())],
        )),
        StoreInButton(),
      ],
    );
  }
}

// SelectThemeButton кнопка темы.
class SelectThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
