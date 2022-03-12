import 'dart:convert';

class karnaliModel {
  static List<Karnali>? karnali;
}

class Karnali {
  final String name;
  final String image;
  final String desc;

  Karnali({
    required this.name,
    required this.image,
    required this.desc,
  });

 

  Karnali copyWith({
    String? name,
    String? image,
    String? desc,
  }) {
    return Karnali(
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

  factory Karnali.fromMap(Map<String, dynamic> map) {
    return Karnali(
      name: map['name'],
      image: map['image'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Karnali.fromJson(String source) => Karnali.fromMap(json.decode(source));

  @override
  String toString() => 'Karnali(name: $name, image: $image, desc: $desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Karnali &&
      other.name == name &&
      other.image == image &&
      other.desc == desc;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ desc.hashCode;
}
