import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listviewapi/models/listphim.dart';
import 'package:listviewapi/network/getdio.dart';

class AllMoviesScreen extends StatefulWidget {
  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  final GetdioClient _client = new GetdioClient();

  List<Listphim> list = <Listphim>[];
  List<Listphim> post = <Listphim>[];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _client.getdata().then((value) {
        post.addAll(value);
        list = post;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _client.getdata(), // here we will get http response
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.only(left: 20, top: 70),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45.0,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.pinkAccent,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 5.0),
                                ]),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter Search movie ...',
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 20,
                                ),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  text = text.toLowerCase();
                                  setState(() {
                                    list = list.where((post) {
                                      var title = post.title!.toLowerCase();
                                      return title.contains(text);
                                    }).toList();
                                  });
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: list.length,
                              itemBuilder: (context, int index) {
                                  return index== 0 ? Container() : _listItem(index-1);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  _searchBar() {
    Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45.0,
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.pinkAccent,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5.0),
          ]),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter Search movie ...',
          hintStyle: TextStyle(
            color: Colors.black26,
            fontSize: 20,
          ),
        ),
        onChanged: (text) {
          setState(() {
            text = text.toLowerCase();
            setState(() {
              list = list.where((post) {
                var title = post.title!.toLowerCase();
                return title.contains(text);
              }).toList();
            });
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 180,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/original/${list[index].posterPath}'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20 - 180,
              height: 255,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    '${list[index].title}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${list[index].releaseDate}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'VoteCount : ${list[index].voteCount}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                        size: 28,
                      ),
                      Text(
                        '${list[index].voteAverage}/10',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
