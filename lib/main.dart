import 'package:flutter/material.dart';
import 'random_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTheme = ThemeData(primaryColor: Colors.redAccent);
    var home = const RandomWords();

    return MaterialApp(theme: appTheme, home: home);
  }
}
