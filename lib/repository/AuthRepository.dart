import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/constants.dart';
import 'package:google_docs_clone/models/ErrorModel.dart';
import 'package:google_docs_clone/models/UserModel.dart';
import 'package:google_docs_clone/repository/local_storage_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (_) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    local_storage_repository: LocalStorageRepository(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;
  // we have provided another instance of google sign in inside the authrepository constructor becasue if we inidialize it with the private constructor, then our code might be breakable
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
    required LocalStorageRepository local_storage_repository,
  })  : _googleSignIn = googleSignIn,
        _client = client,
        _localStorageRepository =
            local_storage_repository; // here we have ensured that the instance which we are passing inside the constructor is assigned to to the private instance _googleSignIn and also of http.client

  Future<ErrorModel> googleSignIn() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    // print(error.error);
    try {
      final user = await _googleSignIn.signIn();
      debugPrint('customLog: $user');
      if (user != null) {
        final userAcc = UserModel(
          email: user.email,
          name: user.displayName ?? '',
          profilePic: user.photoUrl ?? '',
          uid: '',
          token: '',
        );
        var res = await _client.post(
          Uri.parse('$host/api/signup'),
          body: userAcc.toJson(),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        // debugPrint("customLog: ${res.body}");
        // debugPrint("customLog: ${res.statusCode}");

        switch (res.statusCode) {
          case 200:
            var newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;

          case 201: // user already exist
            error = ErrorModel(error: null, data: userAcc);
            break;

          default:
            // do something here
            error = ErrorModel(
              error: "Received a status code of ${res.statusCode}",
              data: null,
            );
            break;
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

  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(error: 'Some error occured', data: null);
    try {
      String? token = await _localStorageRepository.getToken();

      if (token != null) {
        var res = await _client.get(
          Uri.parse('$host/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        switch (res.statusCode) {
          case 200:
            final newUser = UserModel.fromJson(
              jsonEncode(
                jsonDecode(res.body)['user'],
              ),
            ).copyWith(
              token: token,
            ); // setting the token here which we got from the previous response
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }

    return error;
  }

  void signOut() async {
    await _googleSignIn.signOut();
    _localStorageRepository.setToken('');
  }
}
