import 'dart:convert';

class SudhurpaschimModel {
  static List<Sudhurpaschim>? sudhurpaschim;
}

class Sudhurpaschim {
  final String name;
  final String image;
  final String desc;

  Sudhurpaschim({
    required this.name,
    required this.image,
    required this.desc,
  });

 

  Sudhurpaschim copyWith({
    String? name,
    String? image,
    String? desc,
  }) {
    return Sudhurpaschim(
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

  factory Sudhurpaschim.fromMap(Map<String, dynamic> map) {
    return Sudhurpaschim(
      name: map['name'],
      image: map['image'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sudhurpaschim.fromJson(String source) => Sudhurpaschim.fromMap(json.decode(source));

  @override
  String toString() => 'Sudhurpaschim(name: $name, image: $image, desc: $desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Sudhurpaschim &&
      other.name == name &&
      other.image == image &&
      other.desc == desc;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ desc.hashCode;
}
