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
      body: FutureBuilder(
            future: _client.getdata(), // here we will get http response
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridviewHome(movies: list, client: _client);
              } else {
                return CircularProgressIndicator();
              }
            }),
    );
  }
}
