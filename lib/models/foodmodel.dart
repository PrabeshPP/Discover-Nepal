import 'dart:convert';

class FoodModel {
  static List<Food>? food;
}

class Food {
  final String name;
  final String image;
  final String desc;

  Food({
    required this.name,
    required this.image,
    required this.desc,
  });

  Food copyWith({
    String? name,
    String? image,
    String? desc,
  }) {
    return Food(
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

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'],
      image: map['image'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source));

  @override
  String toString() => 'Food(name: $name, image: $image, desc: $desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Food &&
      other.name == name &&
      other.image == image &&
      other.desc == desc;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ desc.hashCode;
}
