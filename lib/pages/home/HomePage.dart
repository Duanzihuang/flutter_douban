import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:'首页',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:new Scaffold(
        body:new Center(
          child:new Text('首页')
        )
      )
    );
  }
}