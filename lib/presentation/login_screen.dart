import 'package:flutter/material.dart';

import 'package:chronus/containers/google_auth_button_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/hourglass.png',
            width: 105.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Chronus',
            style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.title.fontSize),
          ),
          SizedBox(
            height: 60.0,
          ),
          GoogleAuthButtonContainer(),
          SizedBox(
            height: 30.0,
          ),
          MaterialButton(
            minWidth: 300.0,
            height: 42.0,
            onPressed: () {},
            color: Colors.blue,
            child: Text('Log In with facebook',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ))),
    );
  }
}
