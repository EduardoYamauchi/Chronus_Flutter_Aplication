import 'package:flutter/material.dart';

import 'package:chronus/containers/history_container.dart';
import 'package:chronus/containers/tasks_container.dart';
import 'package:chronus/containers/timer_container.dart';

class MenuBar extends StatefulWidget {
  final VoidCallback getHourglassesDataAction;
  final VoidCallback getTasksDataAction;
  final VoidCallback getUserDataAction;

  MenuBar({
    this.getHourglassesDataAction,
    this.getTasksDataAction,
    this.getUserDataAction,
  });

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuBar> {
  final PageStorageBucket bucket = PageStorageBucket();

  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');
  final Key keyThree = PageStorageKey('pageThree');

  int currentTabIndex = 0;
  TimerContainer one;
  HourglassHistoryContainer two;
  TasksContainer three;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    widget.getHourglassesDataAction();
    widget.getTasksDataAction();
    widget.getUserDataAction();
    one = TimerContainer(
      key: keyOne,
    );
    two = HourglassHistoryContainer(key: keyTwo);
    three = TasksContainer(
      key: keyThree,
    );
    pages = [one, two, three];
    currentPage = one;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Theme.of(context).accentColor,
        currentIndex: currentTabIndex,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: Text('Hourglass'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("History"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            title: Text("Tasks"),
          ),
        ],
      ),
    );
  }
}
