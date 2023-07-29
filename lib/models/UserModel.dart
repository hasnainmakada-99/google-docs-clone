import 'dart:convert';

class UserModel {
  String name;
  String uid;
  String email;
  String profilePic;
  String token;

  UserModel({
    required this.name,
    required this.uid,
    required this.email,
    required this.profilePic,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['_id'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? uid,
    String? email,
    String? profilePic,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      token: token ?? this.token,
    );
  }
}
