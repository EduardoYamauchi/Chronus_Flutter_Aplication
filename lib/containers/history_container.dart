import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/models/app_state.dart';
import 'package:chronus/models/hourglass.dart';
import 'package:chronus/presentation/history_screen.dart';
import 'package:chronus/selectors/selectors.dart';

class HourglassHistoryContainer extends StatelessWidget {
  HourglassHistoryContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return HistoryScreen(
          hourglasses: vm.hourglass,
          loading: vm.loading,
          loadHourglassesAction: vm.loadHourglassesAction,
          count: vm.hourglass.length,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Hourglass> hourglass;
  final bool loading;
  final Function loadHourglassesAction;

  _ViewModel(
      {@required this.hourglass,
      @required this.loading,
      @required this.loadHourglassesAction});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        hourglass: hourglassesSelector(store.state),
        loading: store.state.ifLoading,
        loadHourglassesAction: () => store
            .dispatch(GetHourglassesDataAction(userIdSelector(store.state))));
  }
}
