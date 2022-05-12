import 'package:flutter/material.dart';
import 'package:ryanairapp/test_pages/airport.dart';
import 'package:ryanairapp/main.dart';
import 'package:ryanairapp/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<List<Airport>> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://www.ryanair.com/api/locate/v1/autocomplete/airports?phrase=&market=en-ie'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Airport>((json) => Airport.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}


class CheapestPage extends StatefulWidget {
  const CheapestPage({ Key? key }) : super(key: key);

  @override
  State<CheapestPage> createState() => _CheapestPageState();
}

class _CheapestPageState extends State<CheapestPage> {

   late Future<List<Airport>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cheapest Page'
        ),
      ),
      body: FutureBuilder<List<Airport>>(
    future: futurePost,
    builder: (context, snapshot){
      if(snapshot.hasData){
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (_,index) => Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "${snapshot.data![index].code}"
                ),
                Text(
                  "${snapshot.data![index].name}",
                ),
              ],
            ),
          ),
        );
      }else{
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  ),
    );
  }
}

