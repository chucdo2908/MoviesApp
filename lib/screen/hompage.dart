import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listviewapi/models/listphim.dart';
import 'package:listviewapi/network/getdio.dart';
import 'package:listviewapi/widgets/gridview_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GetdioClient _client = new GetdioClient();

  List<Listphim> list = <Listphim>[];



  void _listphim() async {
    final movies = await _client!.getdata();
    setState(() {
      list = movies;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listphim();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Align(
          child: Text("Home"),
          alignment: Alignment.center,
        ),
        actions: [
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                width: 36,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.people,
                  color: Colors.red,
                ),
              ),
          ),

        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _client.getdata(), // here we will get http response
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridviewHome(movies: list, client: _client);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),

    );
  }
}
