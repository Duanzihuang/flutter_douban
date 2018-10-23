import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  String movieId;
  MovieDetail({Key key, this.movieId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MovieDetailState(movieId: this.movieId);
  }
}

class MovieDetailState extends State<MovieDetail> {
  String movieId;
  MovieDetailState({Key key, this.movieId});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
            title:
                new Text('正在加载中...', style: new TextStyle(color: Colors.black)),
            backgroundColor: Colors.white),
        body: new Center(child: new Text("电影详情 $movieId")));
  }
}
