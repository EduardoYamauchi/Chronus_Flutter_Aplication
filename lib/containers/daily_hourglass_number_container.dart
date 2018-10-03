import 'package:chronus/selectors/selectors.dart';
import 'package:chronus/utils/time_stamp_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:chronus/models/app_state.dart';
import 'package:chronus/presentation/daily_hourglass_number.dart';

class DailyHourglassNumberContainer extends StatelessWidget {
  DailyHourglassNumberContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return DailyHourglassNumber(
          hourglassDailyNumber: vm.hourglassDailyNumber,
        );
      },
    );
  }
}

class _ViewModel {
  final int hourglassDailyNumber;
  _ViewModel({this.hourglassDailyNumber});
  static _ViewModel fromStore(Store<AppState> store) {
    final timenow = timeStampGenerator();
    final lastDayWorked = userDataSelector(store.state).lastDayWorked;

    return _ViewModel(
        hourglassDailyNumber: timenow == lastDayWorked
            ? userDataSelector(store.state).totalHourglassCompletedToday
            : 0);
  }
}
