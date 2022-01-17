import 'package:flutter/material.dart';
import 'package:listviewapi/models/listphim.dart';
import 'package:listviewapi/models/trailer_model.dart';
import 'package:listviewapi/network/getdio.dart';
import 'package:listviewapi/screen/videotrailer__screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChitietPhim extends StatefulWidget {
  Listphim data;

  ChitietPhim(this.data);

  @override
  _ChitietPhimState createState() => _ChitietPhimState();
}

class _ChitietPhimState extends State<ChitietPhim> {
  final GetdioClient _client = new GetdioClient();
  List<TrailerModel> _listTl = <TrailerModel>[];

  void _listtrailer() async {
    final trailer = await _client.fetchTrailers(widget.data.id!.toInt());
    setState(() {
      _listTl = trailer;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listtrailer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Image(
                  height: 300.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/original/${widget.data.posterPath}'),
                ),
              ),
              Positioned.fill(
                bottom: 10.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(10.0),
                    elevation: 12.0,
                    onPressed: () => print('Play Video'),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      size: 60.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () => print('Add to My List'),
                  icon: Icon(Icons.add),
                  iconSize: 40.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 25.0,
                child: IconButton(
                  onPressed: () => print('Share'),
                  icon: Icon(Icons.share),
                  iconSize: 35.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${widget.data.title}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Text(
                  '${widget.data.voteAverage}/10',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  '⭐ ⭐ ⭐ ⭐',
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Year',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '${widget.data.releaseDate}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'VoteCount',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '${widget.data.voteCount}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Popularity',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '${widget.data.popularity}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 150.0,
                  child: SingleChildScrollView(
                    child: Text(
                      '${widget.data.overview}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Trailer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.5,
                    children: _listTl
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
                                        'https://image.tmdb.org/t/p/original/${widget.data.posterPath}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Transform.translate(
                                  offset: Offset(-27, -20),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 65, vertical: 100),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20),

                                    ),
                                    child: IconButton(
                                      onPressed: () => print('Add to My List'),
                                      icon: Icon(Icons.play_arrow),
                                      iconSize: 60.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                print(item.key.toString());
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => VideoScreen(
                                     controller: YoutubePlayerController(
                                       initialVideoId: item.key.toString(),
                                       flags: YoutubePlayerFlags(
                                         autoPlay: true,
                                         mute: true,
                                       ),
                                     ),

                                   ),
                                    ),
                                 );
                              },
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Align(
                              child: Text(
                                '${item.name}',
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
    );
  }
}
