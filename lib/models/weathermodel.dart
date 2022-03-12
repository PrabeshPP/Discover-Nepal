import 'dart:convert';

class WeatherResponse {
  final String description;
  final String icon;
  final num temp;
  final num pressure;
  final num humidity;
  final String name;
  final num temp_min;
  final num temp_max;
  final num speed;
  final String main;

  WeatherResponse(
      {required this.description,
      required this.icon,
      required this.temp,
      required this.pressure,
      required this.humidity,
      required this.name,
      required this.temp_min,
      required this.temp_max,
      required this.speed,
      required this.main});

  WeatherResponse copyWith(
      {String? description,
      String? icon,
      num? temp,
      num? pressure,
      num? humidity,
      String? name,
      num? temp_min,
      num? temp_max,
      num? speed,
      String? main}) {
    return WeatherResponse(
        description: description ?? this.description,
        icon: icon ?? this.icon,
        temp: temp ?? this.temp,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
        name: name ?? this.name,
        temp_min: temp_min ?? this.temp_min,
        temp_max: temp_max ?? this.temp_max,
        speed: speed ?? this.speed,
        main: main ?? this.main);
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'icon': icon,
      'temp': temp,
      'pressure': pressure,
      'humidity': humidity,
      'name': name,
      'temp_min': temp_min,
      'temp_max': temp_max,
      'speed': speed,
      'main':main
    };
  }

  factory WeatherResponse.fromMap(Map<String, dynamic> map) {
    return WeatherResponse(
        description: map["weather"][0]['description'],
        icon: map["weather"][0]['icon'],
        temp: map["main"]['temp'],
        pressure: map["main"]['pressure'],
        humidity: map["main"]['humidity'],
        name: map['name'],
        temp_min: map["main"]['temp_min'],
        temp_max: map["main"]['temp_max'],
        speed: map["wind"]['speed'],
        main: map["weather"][0]["main"]);
  }

  String toJson() => json.encode(toMap());

  factory WeatherResponse.fromJson(String source) =>
      WeatherResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeatherResponse(description: $description, icon: $icon, temp: $temp, pressure: $pressure, humidity: $humidity, name: $name, temp_min: $temp_min, temp_max: $temp_max, speed: $speed,main:$main)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherResponse &&
        other.description == description &&
        other.icon == icon &&
        other.temp == temp &&
        other.pressure == pressure &&
        other.humidity == humidity &&
        other.name == name &&
        other.temp_min == temp_min &&
        other.temp_max == temp_max &&
        other.speed == speed &&
        other.main == main;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        icon.hashCode ^
        temp.hashCode ^
        pressure.hashCode ^
        humidity.hashCode ^
        name.hashCode ^
        temp_min.hashCode ^
        temp_max.hashCode ^
        speed.hashCode ^
        main.hashCode;
  }
}
