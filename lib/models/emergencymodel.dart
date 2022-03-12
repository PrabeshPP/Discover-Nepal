import 'dart:convert';

class EmergencyModel{
  static List<Emergency>? emergency;
}

class Emergency {
  final String name;
  final String Contact;

  Emergency({
    required this.name,
    required this.Contact,
  });


  Emergency copyWith({
    String? name,
    String? Contact,
  }) {
    return Emergency(
      name: name ?? this.name,
      Contact: Contact ?? this.Contact,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'Contact': Contact,
    };
  }

  factory Emergency.fromMap(Map<String, dynamic> map) {
    return Emergency(
      name: map['name'],
      Contact: map['Contact'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Emergency.fromJson(String source) => Emergency.fromMap(json.decode(source));

  @override
  String toString() => 'Emergency(name: $name, Contact: $Contact)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Emergency &&
      other.name == name &&
      other.Contact == Contact;
  }

  @override
  int get hashCode => name.hashCode ^ Contact.hashCode;
}
