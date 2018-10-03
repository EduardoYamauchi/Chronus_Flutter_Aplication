import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';

final authReducer = combineReducers<FirebaseUser>([
   TypedReducer<FirebaseUser, GoogleLogInSuccessfulAction>(_logIn),
   TypedReducer<FirebaseUser, GoogleLogoutAction>(_logOut),
]);

FirebaseUser _logIn(FirebaseUser user, action) {
  return action.user;
}

Null _logOut(FirebaseUser user, action) {
  return null;
}
