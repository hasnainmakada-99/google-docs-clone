// import 'dart:convert';

// // ignore_for_file: public_member_api_docs, sort_constructors_first

// class UserModel {
//   String name;
//   String uid;
//   String email;
//   String profilePic;
//   String token;

//   UserModel({
//     required this.name,
//     required this.uid,
//     required this.email,
//     required this.profilePic,
//     required this.token,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'uid': uid,
//       'email': email,
//       'profilePic': profilePic,
//       'token': token,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       name: map['name'] as String,
//       uid: map['_id'] as String,
//       email: map['email'] as String,
//       profilePic: map['profilePic'] as String,
//       token: map['token'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   UserModel copyWith({
//     String? name,
//     String? uid,
//     String? email,
//     String? profilePic,
//     String? token,
//   }) {
//     return UserModel(
//       name: name ?? this.name,
//       uid: uid ?? this.uid,
//       email: email ?? this.email,
//       profilePic: profilePic ?? this.profilePic,
//       token: token ?? this.token,
//     );
//   }
// }

import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String profilePic;
  final String uid;
  final String token;
  UserModel({
    required this.email,
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['_id'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? email,
    String? name,
    String? profilePic,
    String? uid,
    String? token,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
