import 'package:flutter/material.dart';

class MinePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:'我的',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:new Scaffold(
        body:new Center(
          child:new Text('我的')
        )
      )
    );
  }
}