import 'package:flutter/material.dart';
import 'package:flutter_dust/models/air_result.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:flutter_dust/bloc/air_bloc.dart';

void main() {
  runApp(MyApp());
}

// Bloc
final airBloc = AirBloc();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Main()
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final _good = 50;
  final _normal = 100;
  final _bad = 150;
  // AirResult _result;
  
  // Future<AirResult> fetchData() async {
  //   var response = await http.get('https://api.airvisual.com/v2/nearest_city?key=ed9aabae-3d0d-442a-ba71-8f8fb8a14aff');
  //   AirResult result = AirResult.fromJson(json.decode(response.body));
  //   return result;
  // }

  void _onPressedRefresh() {
    // fetchData().then((airResult) {
    //   setState(() {
    //     _result = airResult;
    //   });
    // }).catchError((err) {
    //   print(err);
    // });
    airBloc.fetch();
  }

  Color getColor(AirResult result) {
    if (result != null && result.data.current != null) {
      if (result.data.current.pollution.aqius <= _good) return Colors.green;
      else if (result.data.current.pollution.aqius <= _normal) return Colors.yellow;
      else if (result.data.current.pollution.aqius <= _bad) return Colors.orange;
      else return Colors.red;
    }
    return null;
  }

  String getString(AirResult result) {
    if (result != null && result.data.current != null) {
      if (result.data.current.pollution.aqius <= _good) return '좋음';
      else if (result.data.current.pollution.aqius <= _normal) return '보통';
      else if (result.data.current.pollution.aqius <= _bad) return '나쁨';
      else return '최악';
    }
    return null;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData().then((airResult) {
  //     setState(() {
  //       _result = airResult;
  //     });
  //   }).catchError((err) {
  //     print(err);
  //   });
  // }

  Widget buildBody(AirResult result) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('현재 위치 미세먼지', style: TextStyle(fontSize: 30)),
            SizedBox(height:16,),
            Text('${result.data.city}  ${result.data.location.coordinates}'),
            SizedBox(height:16,),
            Card(
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(8),
                  color: getColor(result),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('얼굴사진'),
                      Text('${result.data.current.pollution.aqius}', style: TextStyle(fontSize: 40)),
                      Text(getString(result), style: TextStyle(fontSize: 20)),
                    ]
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(children: [
                        Image.network('https://airvisual.com/images/${result.data.current.weather.ic}.png', width: 28),
                        SizedBox(width: 16),
                        Text('${result.data.current.weather.tp}°', style: TextStyle(fontSize: 16)),
                      ],),
                      Text('습도 ${result.data.current.weather.hu}%'),
                      Text('풍속 ${result.data.current.weather.ws}m/s'),
                    ]
                  ),
                )
              ],)
            ),
            SizedBox(height:16,),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                color: Colors.grey,
                child: Icon(Icons.refresh, color: Colors.white),
                onPressed: _onPressedRefresh,
              )
            )
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<AirResult>(
          stream: airBloc.airResult$,  
          builder: (context, snapshot) => snapshot.hasData ? buildBody(snapshot.data) : CircularProgressIndicator(),),
      )
    );
  }
}