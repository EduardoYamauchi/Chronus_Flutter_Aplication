import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/presentation/google_auth_button.dart';
import 'package:chronus/models/app_state.dart';

class GoogleAuthButtonContainer extends StatelessWidget {
  GoogleAuthButtonContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return  GoogleAuthButton(
          buttonText: vm.buttonText,
          googleLogInAction: vm.googleLogInAction,
        );
      },
    );
  }
}

class _ViewModel {
  final String buttonText;
  final Function googleLogInAction;

  _ViewModel({this.googleLogInAction, this.buttonText});

  static _ViewModel fromStore(Store<AppState> store) {
    return  _ViewModel(
        googleLogInAction: () => store.dispatch( GoogleLogInAction()));
  }
}
