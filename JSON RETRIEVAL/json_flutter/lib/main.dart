import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState()=> new HomePageState();

}

class HomePageState extends State<HomePage>{
  final String url="https://swapi.co/api/people";
  List data;
  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }
  Future<String> getJsonData() async{
    //  WE wait till we get a response.
    var response = await http.get(
      // to remove spaces by encoding
      Uri.encodeFull(url),
      // only accept JSON RESPONSE
      headers: {"Accept":"application/json"}
    );
    print(response.body);
    setState(() {
      // 
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });

    return "SUCESS";

  }

  @override
  Widget build(BuildContext context){

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("REtrieve json data via http GET"),
      ),
      body: new ListView.builder(
        itemCount: data==null?0:data.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            child:new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        } ,
      ),
    );

  }
}