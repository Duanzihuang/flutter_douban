import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../movie/MoviePage.dart';
import '../mine/MinePage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '首页',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: new HomePageWidget());
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePageState();
  }
}

class HomePageState extends State<HomePageWidget> {
  List<String> images = [
    'http://www.itcast.cn/images/slidead/BEIJING/2017410109413000.jpg',
    'http://www.itcast.cn/images/slidead/BEIJING/2017440109442800.jpg',
    'http://www.itcast.cn/images/slidead/BEIJING/2017441409442800.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = new TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        fontSize: 14.0);
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
            title: new Text('首页', style: new TextStyle(color: Colors.black)),
            backgroundColor: Colors.white),
        body: new Container(
            height: 300.0,
            child: new Column(children: <Widget>[
              new Container(
                  height: 250.0,
                  child: new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new Image.network(
                          images[index],
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: images.length,
                      pagination: new SwiperPagination(),
                      control: new SwiperControl())),
              new Container(
                  color: Colors.orangeAccent,
                  height: 50.0,
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Text("首页", style: textStyle),
                        new InkWell(
                            onTap: () {
                              print(this);
                            },
                            child: new Text("电影", style: textStyle)),
                        new InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/mine');
                            },
                            child: new Text("我的", style: textStyle))
                      ]))
            ])));
  }
}
