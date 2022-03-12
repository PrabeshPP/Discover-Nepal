import 'dart:convert';

class GandakiModel {
  static List<Gandaki>? gandaki;
}

class Gandaki {
  final String name;
  final String img;
  final String desc;

  Gandaki({
    required this.name,
    required this.img,
    required this.desc,
  });

 

  Gandaki copyWith({
    String? name,
    String? img,
    String? desc,
  }) {
    return Gandaki(
      name: name ?? this.name,
      img: img ?? this.img,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'img': img,
      'desc': desc,
    };
  }

  factory Gandaki.fromMap(Map<String, dynamic> map) {
    return Gandaki(
      name: map['name'],
      img: map['img'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Gandaki.fromJson(String source) => Gandaki.fromMap(json.decode(source));

  @override
  String toString() => 'Gandaki(name: $name, img: $img, desc: $desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Gandaki &&
      other.name == name &&
      other.img == img &&
      other.desc == desc;
  }

  @override
  int get hashCode => name.hashCode ^ img.hashCode ^ desc.hashCode;
}
