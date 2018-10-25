import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
  var movieDetail;
  MovieDetailState({Key key, this.movieId});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadMovieDetailData();
  }

  loadMovieDetailData() async {
    var url = 'https://api.douban.com/v2/movie/subject/$movieId';

    var dio = new Dio();
    Response response = await dio.get(url);

    setState(() {
      movieDetail = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(
                movieDetail == null ? '正在加载中...' : movieDetail["title"],
                style: new TextStyle(color: Colors.black)),
            backgroundColor: Colors.white),
        body: movieDetail == null
            ? new Center(child: new CircularProgressIndicator())
            : new SingleChildScrollView(
                child: new Container(
                    // color: Colors.red,
                    child: new Column(
                children: <Widget>[
                  // 标题和图片
                  new Center(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                            child: new Text(movieDetail["title"],
                                style: new TextStyle(fontSize: 20.0))),
                        new Container(
                            width: 300.0,
                            height: 350.0,
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child:
                                Image.network(movieDetail["images"]["medium"]))
                      ],
                    ),
                  ),

                  // 主要演员和简介
                  new Container(
                    width: 500,
                    alignment: Alignment.centerLeft,
                    // margin: const EdgeInsets.all(10.0),
                    // color: Colors.green,
                    child: new Column(children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: new Text("主要演员：",
                              style: new TextStyle(fontSize: 20.0))),
                      new Container(
                          // color: Colors.purple,
                          height: 200.0,
                          child: new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movieDetail["casts"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return new Container(
                                  width: 100.0,
                                  height: 180.0,
                                  // color:Colors.red,
                                  margin: const EdgeInsets.all(10.0),
                                  child: new Column(children: <Widget>[
                                    new Image.network(movieDetail["casts"]
                                        [index]["avatars"]["small"]),
                                    new Container(
                                        margin: const EdgeInsets.only(top: 8.0),
                                        child: new Text(
                                            movieDetail["casts"][index]["name"],
                                            overflow: TextOverflow.ellipsis))
                                  ]));
                            },
                          )),
                      new Container(
                          margin: const EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: new Text("电影简介：",
                              style: new TextStyle(fontSize: 20.0))),
                      new Container(
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                          alignment: Alignment.centerLeft,
                          child: new Text("  " + movieDetail["summary"],
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  letterSpacing: 5.0,
                                  // wordSpacing:20.0,
                                  color: Colors.grey)))
                    ]),
                  )
                ],
              ))));
  }
}
