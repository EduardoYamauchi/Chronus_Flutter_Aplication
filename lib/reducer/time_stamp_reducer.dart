import 'package:redux/redux.dart';

import 'package:chronus/utils/time_stamp_generator.dart';
import 'package:chronus/actions/actions.dart';

final timeStampReducer = combineReducers<String>([
  TypedReducer<String, SetTimeStampAction>(_setTimeStamp),
]);

String _setTimeStamp(String state , SetTimeStampAction action) {
  String currentDate = timeStampGenerator();
  return currentDate;
}
