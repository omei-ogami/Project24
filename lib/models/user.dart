// There should be more properties

class User {
  User({
    required this.name,
    required this.phone,
    required this.email,
  });

  String? id;
  final String name;
  final String phone;
  final String email;

  User._({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory User.fromMap(Map<String, dynamic> map, String? id){
    return User._(
      id: id, 
      name: map['name'], 
      phone: map['phone'], 
      email: map['email']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}