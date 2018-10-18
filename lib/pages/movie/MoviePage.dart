import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '电影',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // home: new Scaffold(body: new Center(child: new Text('电影'))));
        home: new MoviePageWidget());
  }
}

class MoviePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MoviePageState();
  }
}

class MoviePageState extends State<MoviePageWidget> {
  var _inTheatersList;
  var _comingSoonList;
  var _top250List;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 获取正在热映的数据
    _getMovieListDataByType('in_theaters');

    // 获取即将上映的数据
    _getMovieListDataByType('coming_soon');

    // 获取Top250的数据
    _getMovieListDataByType('top250');
  }

  // 获取 正在热映 & 即将上映 & Top250 的数据
  void _getMovieListDataByType(type) async {
    var httpClient = new HttpClient();
    try {
      var request = await httpClient.getUrl(
          Uri.parse('https://api.douban.com/v2/movie/$type?start=0&count=10'));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsonStr = await response.transform(utf8.decoder).join();
        var data = json.decode(jsonStr);
        // 赋值
        switch (type) {
          case 'in_theaters':
            setState(() {
              _inTheatersList = data["subjects"];
            });
            break;
          case 'coming_soon':
            setState(() {
              _comingSoonList = data["subjects"];
            });
            break;
          case 'top250':
            setState(() {
              _top250List = data["subjects"];
            });
            break;
          default:
        }
      }
    } catch (exception) {}
  }

  @override
  Widget build(BuildContext context) {
    print("---build---");
    print(_inTheatersList);
    print(_comingSoonList);
    print(_top250List);
    // TODO: implement build
    return new Scaffold(body: new Center(child: new Text('电影')));
  }
}
