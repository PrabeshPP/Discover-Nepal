import 'dart:convert';

class BagmatiModel {
  static List<BagmatiItems>? bagmatiitems;
  BagmatiItems getById(num id) =>
      bagmatiitems!.firstWhere((element) => element.id == id, orElse: null);
  BagmatiItems getByPosition(int pos) => bagmatiitems![pos];
}

class BagmatiItems {
  final num id;
  final String name;
  final String image;
  final String desc;

  BagmatiItems({
    required this.desc,
    required this.id,
    required this.name,
    required this.image,
  });

  BagmatiItems copyWith({
    num? id,
    String? name,
    String? image,
    String? desc,
  }) {
    return BagmatiItems(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image': image, 'desc': desc};
  }

  factory BagmatiItems.fromMap(Map<String, dynamic> map) {
    return BagmatiItems(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BagmatiItems.fromJson(String source) =>
      BagmatiItems.fromMap(json.decode(source));

  @override
  String toString() => 'BagmatiItems(id: $id, name: $name, image: $image ,desc:$desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BagmatiItems &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.desc == desc;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode ^ desc.hashCode;
}

class WeatherName3Model {
  static List<WeatherName3>? weathername3;
}

class WeatherName3 {
  final String name;

  WeatherName3({
    required this.name,
  });

  WeatherName3 copyWith({
    String? name,
  }) {
    return WeatherName3(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory WeatherName3.fromMap(Map<String, dynamic> map) {
    return WeatherName3(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherName3.fromJson(String source) =>
      WeatherName3.fromMap(json.decode(source));

  @override
  String toString() => 'WeatherName3(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherName3 && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
