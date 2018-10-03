import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DailyHourglassNumber extends StatelessWidget {
  final int hourglassDailyNumber;

  DailyHourglassNumber({
    @required this.hourglassDailyNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Text("HOURGLASS #" + (hourglassDailyNumber + 1).toString(),
        style: Theme.of(context).textTheme.body2);
  }
}
