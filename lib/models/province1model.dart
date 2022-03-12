import 'dart:convert';

class PopularModel {
  static List<PopularItems>? popularitem;
  PopularItems getById(num id) =>
      popularitem!.firstWhere((element) => element.id == id, orElse: null);
  PopularItems getByPosition(int pos) => popularitem![pos];
}

class PopularItems {
  final num id;
  final String name;
  final String image;
  final String desc;

  PopularItems({
    required this.id,
    required this.name,
    required this.image,
    required this.desc,
  });

 

  PopularItems copyWith({
    num? id,
    String? name,
    String? image,
    String? desc,
  }) {
    return PopularItems(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'desc': desc,
    };
  }

  factory PopularItems.fromMap(Map<String, dynamic> map) {
    return PopularItems(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularItems.fromJson(String source) => PopularItems.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PopularItems(id: $id, name: $name, image: $image, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PopularItems &&
      other.id == id &&
      other.name == name &&
      other.image == image &&
      other.desc == desc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      desc.hashCode;
  }
}
