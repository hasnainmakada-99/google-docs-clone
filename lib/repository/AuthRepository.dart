import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/constants.dart';
import 'package:google_docs_clone/models/ErrorModel.dart';
import 'package:google_docs_clone/models/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

final authRepositoryProvider = Provider<AuthRepository>(
  (_) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: http.Client(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final http.Client _client;
  // we have provided another instance of google sign in inside the authrepository constructor becasue if we inidialize it with the private constructor, then our code might be breakable
  AuthRepository(
      {required GoogleSignIn googleSignIn, required http.Client client})
      : _googleSignIn = googleSignIn,
        _client =
            client; // here we have ensured that the instance which we are passing inside the constructor is assigned to to the private instance _googleSignIn and also of http.client

  Future<ErrorModel> googleSignIn() async {
    ErrorModel error = ErrorModel(
      error: 'Some Unexpected Error Occured',
      data: null,
    );
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
          name: user.displayName ?? '',
          uid: '',
          email: user.email,
          profilePic: user.photoUrl ?? '',
          token: '',
        );
        print(user.email);
        print(user.photoUrl);
        print(user.displayName);
        var res = await _client.post(
          Uri.parse('$HOST/api/signup'),
          body: userAcc.toJson(),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );

            error = ErrorModel(error: null, data: newUser);
          default:
        }
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }
}
