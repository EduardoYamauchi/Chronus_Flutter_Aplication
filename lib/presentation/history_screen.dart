import 'package:flutter/material.dart';

import 'package:chronus/models/hourglass.dart';

class HistoryScreen extends StatelessWidget {
  final List<Hourglass> hourglasses;
  final bool loading;
  final Function loadHourglassesAction;
  final count;

  HistoryScreen(
      {Key key,
      @required this.hourglasses,
      @required this.loading,
      this.loadHourglassesAction,
      this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/hourglass.png', width: 120.0, height: 120.0),
            SizedBox(
              height: 30.0,
            ),
            Text('You dont have any hourglass \n at the moment'),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: hourglasses.length,
        itemBuilder: (BuildContext context, int index) {
          final inReverse = hourglasses.reversed;
          final hourglassesReversed = inReverse.toList();
          final hourglass = hourglassesReversed[index];
          // if (index.isOdd) return Divider();
          String hourglassDate = hourglass.completedTime;
          String hourglasYear = hourglassDate.substring(0, 4);
          String hourglasMonth = hourglassDate.substring(4, 6);
          String hourglasDay = hourglassDate.substring(6, 8);
          String hourglasHour = hourglassDate.substring(9, 11);
          String hourglasMinutes = hourglassDate.substring(11, 13);

          return InkWell(
              onTap: () async {},
              child: ListTile(
                leading: Image.asset(
                  'assets/hourglass.png',
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(hourglass.projectName),
                subtitle: Text(
                    "Hourclass complete in $hourglasDay/$hourglasMonth/$hourglasYear $hourglasHour:$hourglasMinutes"),
              ));
        },
      );
    }
  }
}
