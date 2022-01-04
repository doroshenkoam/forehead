import 'package:flutter/material.dart';

// TODO: цвета поискать получше в макетах.

// colorBG цвет заднего фона.
const colorBG = Color(0xFF111328);
// colorBGAppBar цвет заднего фона app бара.
const colorBGAppBar = Color(0xFF111320);

// styleTextAppBar стиль текста app бара.
const styleTextAppBar = TextStyle(
  fontSize: 18.0,
  color: Colors.amber,
);

// colorSelectThemeButton цвет кнопок выбора тем.
const colorSelectThemeButton = Color(0xFF111315);
// colorInStoreButton цвет кнопки машазина.
const colorInStoreButton = Color(0xAD940123);

// styleTextInStoreButton стиль текста кнопки захода в магазин.
// TODO: сделать текст жирнее.
const styleTextInStoreButton = TextStyle(
  fontSize: 20.0,
  wordSpacing: 8,
  color: Colors.amber,
);

// styleTextWordCard стиль текста для карточек слов.
const styleTextWordCard = TextStyle(
  fontSize: 40.0,
  color: Colors.amber,
);

const gameFinishText = "ИГРА ЗАКОНЧЕНА!";

// styleTextSelectThemeButton стиль текста кнопок выбора тем.
const styleTextSelectThemeButton = TextStyle(
  fontSize: 25.0,
  color: Colors.amber,
  fontWeight: FontWeight.bold,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(1.0, 1.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
    Shadow(
      offset: Offset(1.0, 1.0),
      blurRadius: 8.0,
      color: Color.fromARGB(125, 0, 0, 255),
    ),
  ],
);
