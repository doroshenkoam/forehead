import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forehead/const.dart';

// StoreInButton кнопка магазина.
// TODO: сделать кнопку жирнее.
class StoreInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StoreStartPage()),
        );
      },
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            "ПРИКУПИТЬ БОЛЬШЕ СЛОВ",
            style: styleTextInStoreButton,
          ),
        ),
        margin: EdgeInsets.only(bottom: 20, top: 10, left: 30, right: 30),
        decoration: BoxDecoration(
          color: colorInStoreButton,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}

// StoreStartPage стартовая страница магазина.
class StoreStartPage extends StatelessWidget {
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
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(child: BuyBatchWordsButton()),
              Expanded(child: BuyBatchWordsButton())
            ],
          )),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(child: BuyBatchWordsButton()),
              Expanded(child: BuyBatchWordsButton())
            ],
          )),
        ],
      ),
    );
  }
}

// BuyBatchWordsButton кнопка покупки набора слов.
// TODO: перевсти на виджет пролистываня.
// TODO: дописать логику покупки.
class BuyBatchWordsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          // TODO: перевести на картинку для каждого набора
          color: colorSelectThemeButton,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}
