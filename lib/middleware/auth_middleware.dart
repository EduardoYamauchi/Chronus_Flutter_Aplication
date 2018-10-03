import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/models/app_state.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  final logIn = _createLogInMiddleware();
  final logOut = _createLogOutMiddleware();

  return [
     TypedMiddleware<AppState, GoogleLogInAction>(logIn),
     TypedMiddleware<AppState, GoogleLogoutAction>(logOut)
  ];
}

Middleware<AppState> _createLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn =  GoogleSignIn();
    if (action is GoogleLogInAction) {
      try {
        GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        user = await _auth.signInWithGoogle(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        store.dispatch( NavigateToHomeAction());
        store.dispatch( GoogleLogInSuccessfulAction(user: user));
        store.dispatch( AddUserDataBeforeLoginAction(user: user));
      } catch (error) {
        store.dispatch( GoogleLogInFailAction(error));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      store.dispatch( GoogleLogoutSuccessfulAction());
    } catch (error) {
      print(error);
    }
  };
}
