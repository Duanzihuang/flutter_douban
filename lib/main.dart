import 'package:flutter/material.dart';
import 'package:flutter_douban/pages/MainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '豆瓣电影',
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: MainPage());
  }
}
