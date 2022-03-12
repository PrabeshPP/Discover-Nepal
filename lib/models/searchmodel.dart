import 'dart:convert';

class SearchModel {
  static List<Search>? search;
  Search getByName(String name) =>
      search!.firstWhere((element) => element.name == name, orElse: null);
      
}

class Search {
  final String name;

  Search({
    required this.name,
  });

  Search copyWith({
    String? name,
  }) {
    return Search(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Search.fromMap(Map<String, dynamic> map) {
    return Search(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Search.fromJson(String source) => Search.fromMap(json.decode(source));

  @override
  String toString() => 'Search(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Search && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
