import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_douban/pages/movie/MovieDetail.dart';

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
  List movieList = new List();
  int currentPage = 0; // 第一页
  int pageSize = 10; // 页容量
  int totalSize = 0; // 总条数
  ScrollController _controller = new ScrollController();
  TextStyle titleStyle =
      new TextStyle(color: const Color(0xFF757575), fontSize: 14.0);

  MoveListState({Key key, this.movieType}) {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && movieList.length < totalSize) {
        // scroll to bottom, get next page data
        print("load more ... ");
        loadMovieListData();
      } else {
        print('no more data');
      }
    });
  }

  // 下拉刷新
  Future _pullToRefresh() async {
    currentPage = 0;
    movieList.clear();
    loadMovieListData();
    return null;
  }

  // 加载列表页面的数据
  loadMovieListData() async {
    // 页码加1
    currentPage = currentPage + 1;

    var start = (currentPage - 1) * pageSize;

    var url =
        'https://api.douban.com/v2/movie/$movieType?start=$start&count=$pageSize';

    var dio = new Dio();
    Response response = await dio.get(url);

    setState(() {
      movieList.addAll(response.data["subjects"]);
      totalSize = response.data["total"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 加载第一页的数据
    loadMovieListData();

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
    // 有数据，显示ListView
    Widget listView = null;
    if (movieList != null) {
      listView = new ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, i) => renderRow(i, context),
        controller: _controller,
      );
    }
    // TODO: implement build
    return new Scaffold(
        backgroundColor: const Color(0xFFe9e9ef),
        appBar: new AppBar(
            title: new Text(typeName != null ? typeName : '正在加载中...',
                style: new TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            iconTheme: new IconThemeData(color: Colors.black)),
        body: movieList == null
            ? new Center(
                // CircularProgressIndicator是一个圆形的Loading进度条
                child: new CircularProgressIndicator(),
              )
            : new RefreshIndicator(child: listView, onRefresh: _pullToRefresh));
  }

  Widget renderRow(i, context) {
    var movie = movieList[i];
    var id = movie["id"];
    var title = movie["title"];
    var type = movie["genres"].join('、');
    var year = movie["year"];
    var score = movie["rating"]["average"];
    return new InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (ctx) => new MovieDetail(movieId: id)));
        },
        child: new Container(
            height: 200.0,
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                // 头像和描述部分
                new Container(
                  height: 199.0,
                  child: new Row(children: <Widget>[
                    new Container(
                        width: 120.0,
                        height: 180.0,
                        margin: const EdgeInsets.all(10.0),
                        child: Image.network(movie["images"]["small"])),
                    new Container(
                      height: 180.0,
                      margin: const EdgeInsets.all(12.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('电影名称：$title',
                              style: titleStyle,
                              overflow: TextOverflow.ellipsis),
                          new Text('电影类型：$type',
                              style: titleStyle,
                              overflow: TextOverflow.ellipsis),
                          new Text('上映年份：$year',
                              style: titleStyle,
                              overflow: TextOverflow.ellipsis),
                          new Text('豆瓣评分：$score',
                              style: titleStyle,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    )
                  ]),
                ),
                //分割线
                new Divider(height: 1.0)
              ],
            )));
  }
}
