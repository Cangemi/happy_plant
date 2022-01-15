import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_plant/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MaterialApp(
    home: Home() ,
    theme: ThemeData(
      primaryColor: Color(0xffF2C12E),
      scaffoldBackgroundColor: Color(0xffF1FED9),
      appBarTheme: AppBarTheme(color: Color(0xffF2C12E))
    ),
  ));
}

