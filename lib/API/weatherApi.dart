import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nepaltourisguide/models/weathermodel.dart';

class Dataservice {
  Future<WeatherResponse> loadData(city) async {
    final CityName = city;
    final units = "metric";
    final APIID = "b0c19d3ee82706b5745763baa2302143";
    final Url =
        "https://api.openweathermap.org/data/2.5/weather?q=${CityName}&units=${units}&appid=${APIID}";

    final response = await http.get(Uri.parse(Url));
    if (response.statusCode == 200) {
      return WeatherResponse.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
