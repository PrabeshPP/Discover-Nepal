import 'dart:convert';

class EmergencyModel{
  static List<Emergency>? emergency;
}

class Emergency {
  final String name;
  final String contact;

  Emergency({
    required this.name,
    required this.contact,
  });


  Emergency copyWith({
    String? name,
    String? contact,
  }) {
    return Emergency(
      name: name ?? this.name,
      contact: contact ?? this.contact,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'Contact': contact,
    };
  }

  factory Emergency.fromMap(Map<String, dynamic> map) {
    return Emergency(
      name: map['name'],
      contact: map['Contact'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Emergency.fromJson(String source) => Emergency.fromMap(json.decode(source));

  @override
  String toString() => 'Emergency(name: $name, Contact: $contact)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Emergency &&
      other.name == name &&
      other.contact == contact;
  }

  @override
  int get hashCode => name.hashCode ^ contact.hashCode;
}
