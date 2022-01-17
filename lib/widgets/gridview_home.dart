import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:listviewapi/models/listphim.dart';
import 'package:listviewapi/network/getdio.dart';
import 'package:listviewapi/screen/allmoveis_screen.dart';
import 'package:listviewapi/screen/chitietphim.dart';

class GridviewHome extends StatelessWidget {
  GetdioClient? client = new GetdioClient();

  final List<Listphim> movies;

  GridviewHome({required this.movies, required this.client});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: client!.getdata,
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 20, top: 50),
              width: MediaQuery.of(context).size.width,
              color: Colors.white60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Text(
                    'Movie App',
                    style: TextStyle(
                      fontFamily: 'SubstanceMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.pink,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                 TextField(
                   decoration: InputDecoration(
                     hintText: 'Enter Search movie ...',
                     hintStyle: TextStyle(
                       color: Colors.black26,
                       fontSize: 20,
                     ),
                   ),
                   onChanged: (text) {
                     text = text.toLowerCase();
                     client = movies.where((element){
                       var post = element.title!.toLowerCase();
                       return post.contains(text);
                     }).toList() as GetdioClient;
                   },
                 ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 24,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Text(
                            'Recent',
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          child: GestureDetector(
                            child: Text(
                            'See all',
                            style: TextStyle(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AllMoviesScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, int index) {
                          return Row(
                            children: <Widget>[
                              InkWell(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 278.0,
                                    minWidth:
                                        MediaQuery.of(context).size.width *
                                            0.40,
                                    maxHeight: 278.0,
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.40,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                        child: Image.network(
                                            'https://image.tmdb.org/t/p/original/${movies[index].posterPath}'),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Align(
                                        child: Text(
                                          '${movies[index].title}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChitietPhim(movies[index])
                                      ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          );
                        },
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 24,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Text(
                            'Popular',
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.7,
                      children: movies
                          .map(
                            (item) => Container(
                              padding: EdgeInsets.only(right: 20.0),
                              color: Colors.transparent,
                              child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/original/${item.posterPath}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Transform.translate(
                                        offset: Offset(61, -96),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 65, vertical: 100),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.red,
                                          ),
                                          child: Align(
                                            child: Text(
                                              '${item.voteAverage}',
                                              style: TextStyle(
                                                color: Colors.amberAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ChitietPhim(item)
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 7.0,
                                  ),
                                  Align(
                                    child: Text(
                                      '${item.title}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
