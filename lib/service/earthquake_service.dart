import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/earthquake_model.dart';

class EarthquakeService {
  Future<List<EarthquakeModel>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://api.berkealp.net/kandilli/index.php?all'));

    if (response.statusCode == 200) {
      final data = await json.decode(response.body);
      List<EarthquakeModel> results = [];

      for (var item in data) {
        results.add(EarthquakeModel.fromJson(item));
      }
      return results;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
