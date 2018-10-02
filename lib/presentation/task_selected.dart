import 'package:flutter/material.dart';

class TaskSelected extends StatelessWidget {
  final String taskSelected;

  TaskSelected({@required this.taskSelected});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$taskSelected",
      style: Theme.of(context).textTheme.subhead,
    );
  }
}
