import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  String movieType;

  MovieList({Key key, this.movieType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MoveListState(movieType: this.movieType);
  }
}

class MoveListState extends State<MovieList> {
  String movieType;
  String typeName;

  MoveListState({Key key, this.movieType});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      switch (movieType) {
        case 'in_theaters':
          typeName = '正在热映';
          break;
        case 'coming_soon':
          typeName = '即将上映';
          break;
        case 'top250':
          typeName = 'Top250';
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: const Color(0xFFe9e9ef),
      appBar: new AppBar(
          title: new Text(typeName != null ? typeName : '正在加载中...',
              style: new TextStyle(color: Colors.black)),
          backgroundColor: Colors.white),
      body: new Center(child: new Text("1111")),
    );
  }
}
