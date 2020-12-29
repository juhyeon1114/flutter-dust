import 'package:flutter_dust/models/air_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class AirBloc {
  // properties
  final _airSubject = BehaviorSubject<AirResult>(); // strem을 지원함

  // constructor
  AirBloc() {
    fetch();
  }

  // methods
  void fetch() async {
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

  Stream<AirResult> get airResult$ => _airSubject.stream;

  Future<AirResult> fetchData() async {
    var response = await http.get('https://api.airvisual.com/v2/nearest_city?key=ed9aabae-3d0d-442a-ba71-8f8fb8a14aff');
    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }
}