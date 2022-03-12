import 'dart:convert';

class MoreImagesModel {
  static List<MoreImages>? moreimages;
}

class MoreImages {
  
  final String img1;
  final String img2;
  final String img3;

  MoreImages(
      {
      required this.img1,
      required this.img2,
      required this.img3});

  MoreImages copyWith({
  
    String? img1,
    String? img2,
    String? img3,
  }) {
    return MoreImages(
     
      img1:img1 ?? this.img1,
      img2:img2 ?? this.img2,
      img3:img3 ?? this.img3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      
      'img1': img1,
      'img2': img2,
      'img3': img3,
    };
  }

  factory MoreImages.fromMap(Map<String, dynamic> map) {
    return MoreImages(
      
      img1:map['img1'],
      img2:map['img2'],
      img3:map['img3'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MoreImages.fromJson(String source) =>
      MoreImages.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MoreImages( img1: $img1, img2: $img2, img3: $img3)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoreImages &&
      
        other.img1 == img1 &&
        other.img2 == img2 &&
        other.img3 == img3;
  }

  @override
  int get hashCode {
    return  img1.hashCode ^ img2.hashCode ^ img3.hashCode;
  }
}
