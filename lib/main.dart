import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:chronus/presentation/login_screen.dart';
import 'package:chronus/middleware/auth_middleware.dart';
import 'package:chronus/middleware/epic_middleware.dart';
import 'package:chronus/middleware/navigation_middleware.dart';
import 'package:chronus/models/app_state.dart';
import 'package:chronus/reducer/app_reducer.dart';

final navigatorKey =  GlobalKey<NavigatorState>();

void main() => runApp(Chronus());

class Chronus extends StatelessWidget {
  final Store<AppState> store;

  Chronus({
    Key key,
  }) : store = Store<AppState>(appReducer,
            initialState: AppState(),
            middleware: [EpicMiddleware(allEpics)]
              ..addAll(createAuthMiddleware())
              ..addAll(createNavigationMiddleware(navigatorKey))
              ..add(LoggingMiddleware.printer()));

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Chronus',
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.grey[900],
              accentColor: Color.fromRGBO(16, 171, 156, 1.0)),
          home: HomeScreen(),
        ));
  }
}
