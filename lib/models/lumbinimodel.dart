import 'dart:convert';

class LumbiniModel {
  static List<Lumbini>? lumbini;
}

class Lumbini {
  final String name;
  final String image;
  final String desc;

  Lumbini({
    required this.name,
    required this.image,
    required this.desc,
  });

  

  Lumbini copyWith({
    String? name,
    String? image,
    String? desc,
  }) {
    return Lumbini(
      name: name ?? this.name,
      image: image ?? this.image,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'desc': desc,
    };
  }

  factory Lumbini.fromMap(Map<String, dynamic> map) {
    return Lumbini(
      name: map['name'],
      image: map['image'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lumbini.fromJson(String source) => Lumbini.fromMap(json.decode(source));

  @override
  String toString() => 'Lumbini(name: $name, image: $image, desc: $desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Lumbini &&
      other.name == name &&
      other.image == image &&
      other.desc == desc;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ desc.hashCode;
}
