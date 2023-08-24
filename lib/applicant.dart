import 'dart:convert';

class Applicant {
  String name;
  String id;
  String cert;
  String country;
  String occupation;
  String gender;
  int age;
  int xpYrs;

  Applicant({
    required this.name,
    required this.id,
    required this.cert,
    required this.country,
    required this.occupation,
    required this.gender,
    required this.age,
    required this.xpYrs,
  });

  Applicant copyWith({
    String? name,
    String? id,
    String? cert,
    String? country,
    String? occupation,
    String? gender,
    int? age,
    int? xpYrs,
  }) {
    return Applicant(
      name: name ?? this.name,
      id: id ?? this.id,
      cert: cert ?? this.cert,
      country: country ?? this.country,
      occupation: occupation ?? this.occupation,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      xpYrs: xpYrs ?? this.xpYrs,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'id': id});
    result.addAll({'cert': cert});
    result.addAll({'country': country});
    result.addAll({'occupation': occupation});
    result.addAll({'gender': gender});
    result.addAll({'age': age});
    result.addAll({'xpYrs': xpYrs});
  
    return result;
  }

  factory Applicant.fromMap(Map<String, dynamic> map) {
    return Applicant(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      cert: map['cert'] ?? '',
      country: map['country'] ?? '',
      occupation: map['occupation'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age']?.toInt() ?? 0,
      xpYrs: map['xpYrs']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Applicant.fromJson(String source) => Applicant.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Applicant(name: $name, id: $id, cert: $cert, country: $country, occupation: $occupation, gender: $gender, age: $age, xpYrs: $xpYrs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Applicant &&
      other.name == name &&
      other.id == id &&
      other.cert == cert &&
      other.country == country &&
      other.occupation == occupation &&
      other.gender == gender &&
      other.age == age &&
      other.xpYrs == xpYrs;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      id.hashCode ^
      cert.hashCode ^
      country.hashCode ^
      occupation.hashCode ^
      gender.hashCode ^
      age.hashCode ^
      xpYrs.hashCode;
  }
}
