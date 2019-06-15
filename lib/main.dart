import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';



Map _quakes;
List _features;
void main() async{

  _quakes =  await getQuake();
  print(_quakes);
  _features = _quakes['feature'];
  for(int i=0; i< _quakes.length; i++){
    print(_quakes[i]['features'][0]['properties']);
  }

  runApp(
    MaterialApp(
      title: 'Quake',
      home: Quake(),
    )
  );
}


class Quake extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("QUAKE",
        style: new TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: new Container(
        child: new Center(
          child: new ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _features.length,
              itemBuilder: (BuildContext context, int position){
                if(position.isOdd) return Divider();
                final index = position ~/2;
                return new ListTile(
                  title: new Text("${_features[index]['properties']['place']}"),
                  subtitle: new Text("${_features[index]['properties']['place']}",style: new TextStyle(color: Colors.black,fontStyle: FontStyle.italic),),
                  leading: new CircleAvatar(backgroundColor: Colors.blue,
                    child: new Text("${_features[index]['properties']['place']}"),
                  ),
                );

              }
        ),
      ),
      ),
    );
  }

}

Future<Map> getQuake() async{

  String apiUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}