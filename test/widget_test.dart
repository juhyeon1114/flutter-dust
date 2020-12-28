import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_dust/main.dart';
import 'package:http/http.dart' as http;


void main() {
  test('http 통신 테스트', () async {
    var response = await http.get('https://api.airvisual.com/v2/nearest_city?key=ed9aabae-3d0d-442a-ba71-8f8fb8a14aff');
    expect(response.statusCode, 200);
  });
}
