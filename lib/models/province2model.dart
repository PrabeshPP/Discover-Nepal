import 'dart:convert';

class Province2Model {
  static List<Province22>? province2;
  Province22 getById(num id) =>
      province2!.firstWhere((element) => element.id == id, orElse: null);
  Province22 getByPosition(int pos) => province2![pos];
}

class Province22 {
  final num id;
  final String name;
  final String image;
  final String desc;

  Province22( {
   required  this.desc,
    required this.id,
    required this.name,
    required this.image,
  });

  Province22 copyWith({
    num? id,
    String? name,
    String? image,
    String? desc
  }) {
    return Province22(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image, 
      desc:desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'desc':desc
    };
  }

  factory Province22.fromMap(Map<String, dynamic> map) {
    return Province22(
      id: map['id'],
      name: map['name'],
      image: map['image'], 
      desc: map["desc"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Province22.fromJson(String source) =>
      Province22.fromMap(json.decode(source));

  @override
  String toString() => 'Province22(id: $id, name: $name, image: $image,desc:$desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Province22 &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.desc==desc;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode ^desc.hashCode;
}

class WeatherName2Model {
  static List<WeatherName2>? weathername2;
}

class WeatherName2 {
  final String name;

  WeatherName2({
    required this.name,
  });

  WeatherName2 copyWith({
    String? name,
  }) {
    return WeatherName2(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory WeatherName2.fromMap(Map<String, dynamic> map) {
    return WeatherName2(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherName2.fromJson(String source) =>
      WeatherName2.fromMap(json.decode(source));

  @override
  String toString() => 'WeatherName2(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherName2 && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
