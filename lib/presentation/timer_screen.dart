import 'dart:math' as math;

import 'package:chronus/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:chronus/containers/daily_hourglass_number_container.dart';
import 'package:chronus/containers/task_selected_container.dart';

class TimerScreen extends StatefulWidget {
  final VoidCallback addHourglassAction;
  final VoidCallback setTimeStampAction;
  final UserData userData;

  TimerScreen({
    Key key,
    this.addHourglassAction,
    this.setTimeStampAction,
    this.userData,
  }) : super(key: key);

  @override
  TimerState createState() => TimerState();
}

enum ActualEvent { pomodoro, shortBreak, longBreak }

class TimerState extends State<TimerScreen> with TickerProviderStateMixin {
  AnimationController controller;

  var actualEvent;
  int pomodoroCounter = 1;

  static Duration pomodoroDuration = Duration(seconds: 10);
  static Color pomodoroColor = Colors.redAccent;

  static Duration shortBreakDuration = Duration(seconds: 5);
  static Duration longBreakDuration = Duration(seconds: 8);
  static Color breakColor = Colors.greenAccent;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var android = AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var platform = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    actualEvent = ActualEvent.pomodoro;

    controller = AnimationController(vsync: this, duration: pomodoroDuration);
    resetController();

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.dismissed) {
        switch (actualEvent) {
          case ActualEvent.pomodoro:
            if (pomodoroCounter % 4 == 0) {
              actualEvent = ActualEvent.longBreak;
              controller.duration = longBreakDuration;
              showNotification("Longbreak Started!");
            } else {
              actualEvent = ActualEvent.shortBreak;
              controller.duration = shortBreakDuration;
              showNotification("Shortbreak Started!");
            }
            pomodoroCounter++;
            print('Pomodoro finished');
            widget.setTimeStampAction();
            widget.addHourglassAction();
            resetController();
            controller.reverse(
                from: controller.value == 0.0 ? 1.0 : controller.value);
            break;
          case ActualEvent.shortBreak:
            actualEvent = ActualEvent.pomodoro;
            controller.duration = pomodoroDuration;
            print('Shortbreak finished');
            resetController();
            break;
          case ActualEvent.longBreak:
            actualEvent = ActualEvent.pomodoro;
            controller.duration = pomodoroDuration;
            print('Longbreak finished');
            resetController();
            break;
        }
      }
    });
  }

  resetController() {
    controller.value = 1.0;
  }

  showNotification(String message) async {
    var android = AndroidNotificationDetails(
        'CHANNEL ID', "CHANNEL NAME", "CHANNEL DESCRIPTION",
        importance: Importance.High);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);

    await flutterLocalNotificationsPlugin.show(
        0, "Breaktime", "$message", platform);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return CustomPaint(
                                painter: TimerPainter(
                              animation: controller,
                              backgroundColor: Colors.white,
                              color: actualEvent == ActualEvent.pomodoro
                                  ? pomodoroColor
                                  : breakColor,
                            ));
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TaskSelectedContainer(),
                            AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  return Text(
                                    timerString,
                                    style: themeData.textTheme.display4,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  widget.userData == null
                      ? CircularProgressIndicator()
                      : DailyHourglassNumberContainer(),
                  SizedBox(height: 15.0),
                  FloatingActionButton(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Icon(controller.isAnimating
                            ? Icons.pause
                            : Icons.play_arrow);
                      },
                    ),
                    onPressed: () {
                      if (controller.isAnimating) {
                        controller.stop();
                        setState(() {});
                      } else {
                        controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value);
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 7.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
