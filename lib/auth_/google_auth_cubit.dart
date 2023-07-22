import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto/auth_/google_auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  GoogleAuthCubit() : super(GoogleAuthInitialState());
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  void login() async {
    emit(GoogleAuthLoadingState());
    try {
      final userAccount = await _googleSignIn.signIn();

      if (userAccount == null) {
        emit(GoogleAuthFailedState('Google sign-in cancelled.'));
        return;
      }

      final GoogleSignInAuthentication googleAuth = await userAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        emit(GoogleAuthSuccessState(userCredential.user!));
      } else {
        emit(GoogleAuthFailedState('Error signing in with Google.'));
      }
    } catch (e) {
      emit(GoogleAuthFailedState(e.toString()));
    }
  }
}