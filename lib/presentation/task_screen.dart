import 'package:flutter/material.dart';

import 'package:chronus/models/task.dart';

class TaskScreen extends StatefulWidget {
  final List<Task> tasks;
  final count;
  final bool loading;
  final Function selectTaskAction;
  final Function addTaskAction;
  final String taskSelected;

  TaskScreen(
      {Key key,
      @required this.tasks,
      @required this.count,
      @required this.loading,
      @required this.selectTaskAction,
      @required this.addTaskAction,
      @required this.taskSelected})
      : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

final TextEditingController taskCreateName =  TextEditingController();
final TextEditingController taskDescription =  TextEditingController();

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Tasks'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    createTaskDialog(context, widget.addTaskAction);
                  },
                )
              ],
            ),
            body: widget.count == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/hourglass.png',
                            width: 120.0, height: 120.0),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                            'You dont have any task registered \n at the moment'),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final inReverse = widget.tasks.reversed;
                      final tasksReversed = inReverse.toList();
                      final task = tasksReversed[index];
                      return InkWell(
                          onTap: () async {
                            widget.selectTaskAction(task.taskName);
                            _showTaskSelected(context, task.taskName);
                          },
                          child: ListTile(
                            title: Text(task.taskName),
                            subtitle: Text(task.taskDescription),
                            leading: task.taskName == widget.taskSelected
                                ? Icon(Icons.radio_button_checked)
                                : Icon(Icons.radio_button_unchecked),
                          ));
                    },
                  )));
  }
}

void createTaskDialog(BuildContext context, Function addTaskAction) {
  var createProject = AlertDialog(
    title: Center(child: Text('Create a Task')),
    content: Container(
      height: 200.0,
      child: Center(
          child: Column(
        children: <Widget>[
          TextField(
            controller: taskCreateName,
            decoration:  InputDecoration(
              labelText: 'Insert the name of your  task',
            ),
          ),
          TextField(
            controller: taskDescription,
            decoration:  InputDecoration(
              labelText: 'Description of the task',
            ),
          )
        ],
      )),
    ),
    actions: <Widget>[
      FlatButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text('CANCEL')),
      FlatButton(
          onPressed: () async {
            if (taskCreateName.text.isNotEmpty) {
              addTaskAction(taskCreateName.text, taskDescription.text);
            }
            taskCreateName.clear();
            taskDescription.clear();
            Navigator.pop(context);
          },
          child: Text('CREATE')),
    ],
  );
  showDialog(context: context, builder: (context) => createProject);
}

void _showTaskSelected(BuildContext context, String taskName) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).accentColor,
      content: Text('$taskName task selected'),
    ),
  );
}
