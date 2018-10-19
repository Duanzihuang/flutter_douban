import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
    // _getMovieListDataByType('in_theaters');

    // 获取即将上映的数据
    // _getMovieListDataByType('coming_soon');

    // 获取Top250的数据
    // _getMovieListDataByType('top250');

    _getMovieListData();
  }

  // 获取 正在热映 & 即将上映 & Top250 的数据
  /*
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
  */

  // 使用dio实现
  _getMovieListData() async {
    var dio1 = new Dio(new Options(extra: {"type": 'in_theaters'}));
    var dio2 = new Dio(new Options(extra: {"type": 'coming_soon'}));
    var dio3 = new Dio(new Options(extra: {"type": 'top250'}));
    List<Response> responses = await Future.wait([
      dio1.get("https://api.douban.com/v2/movie/in_theaters?start=0&count=10"),
      dio2.get("https://api.douban.com/v2/movie/coming_soon?start=0&count=10"),
      dio3.get("https://api.douban.com/v2/movie/top250?start=0&count=10")
    ]);

    // 遍历返回的数据，赋值给对应的数组
    responses.map((Response response) {
      print(response.data["subjects"]);
      switch (response.request.extra["type"]) {
        case "in_theaters":
          setState(() {
            _inTheatersList = response.data["subjects"];
          });
          break;
        case "coming_soon":
          setState(() {
            _comingSoonList = response.data["subjects"];
          });
          break;
        case "top250":
          setState(() {
            _top250List = response.data["subjects"];
          });
          break;
        default:
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print("---build---");
    print(_inTheatersList);
    print(_comingSoonList);
    print(_top250List);
    // TODO: implement build
    return new Scaffold(
        body: new RaisedButton(
            child: new Center(child: new Text('发请求666')),
            onPressed: () {
              this._getMovieListData();
            }));
  }
}
