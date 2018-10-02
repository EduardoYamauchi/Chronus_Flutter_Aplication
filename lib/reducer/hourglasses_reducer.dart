import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/models/hourglass.dart';

final hourglassesReducer = combineReducers<List<Hourglass>>([
  TypedReducer<List<Hourglass>, LoadHourglassesHistoryAction>(
      _setLoadedHourglasses),
]);

List<Hourglass> _setLoadedHourglasses(
    List<Hourglass> hourglasses, LoadHourglassesHistoryAction action) {
      print(action.hourglasses);
  return action.hourglasses;
}
