import 'package:flutter/material.dart';
import 'package:listviewapi/models/listphim.dart';
import 'package:listviewapi/network/getdio.dart';

class GridviewHome extends StatelessWidget {

  GetdioClient? client = new GetdioClient();

  final List<Listphim> movies;

  GridviewHome({required this.movies, required this.client});


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: client!.getdata,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/images/anhbia.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: movies.map((item) => Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: NetworkImage('https://image.tmdb.org/t/p/original/${item.posterPath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Transform.translate(
                      offset: Offset(63, -63),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 65, vertical: 65),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                )).toList(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

