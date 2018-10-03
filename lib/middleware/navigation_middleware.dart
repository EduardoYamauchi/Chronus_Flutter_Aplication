import 'package:flutter/material.dart';

import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/containers/menu_bar_container.dart';
import 'package:chronus/models/app_state.dart';

List<Middleware<AppState>> createNavigationMiddleware(GlobalKey<NavigatorState> navigatorKey) {
  final _pushToHome = pushToRouteMiddleware(navigatorKey);

  return [ TypedMiddleware<AppState, NavigateToHomeAction>(_pushToHome)];
}

Middleware<AppState> pushToRouteMiddleware(GlobalKey<NavigatorState> navigatorKey) {
  return (Store store, action, NextDispatcher next) async {
    next(action);

    navigatorKey.currentState.push( MaterialPageRoute(builder: (context) {
      return MenuBarContainer();
    }));
  };
}
