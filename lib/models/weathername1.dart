import 'dart:convert';

class WeatherModel1 {
  static List<WeatherName1>? weathername1;
}

class WeatherName1 {
  final String name;

  WeatherName1({
    required this.name,
  });

  WeatherName1 copyWith({
    String? name1,
  }) {
    return WeatherName1(
      name: name1 ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory WeatherName1.fromMap(Map<String, dynamic> map) {
    return WeatherName1(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherName1.fromJson(String source) =>
      WeatherName1.fromMap(json.decode(source));

  @override
  String toString() => 'WeatherName1(name1: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherName1 && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
