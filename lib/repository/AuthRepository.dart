import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (_) => AuthRepository(
    googleSignIn: GoogleSignIn(),
  ),
);

class AuthRepository {
  final GoogleSignIn _googleSignIn;

  // we have provided another instance of google sign in inside the authrepository constructor becasue if we inidialize it with the private constructor, then our code might be breakable
  AuthRepository({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn =
            googleSignIn; // here we have ensured that the instance which we are passing inside the constructor is assigned to to the private instance _googleSignIn

  void googleSignIn() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        print(user.email);
        print(user.displayName);
        print(user.photoUrl);
      }
    } catch (e) {
      print(e);
    }
  }
}
