import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/models/user_data.dart';

final userDataReducer = combineReducers<UserData>([
  TypedReducer<UserData, LoadUserDataAction>(_setLoadedUserData),
]);

UserData _setLoadedUserData(UserData userData, LoadUserDataAction action) {
  return action.userData;
}
