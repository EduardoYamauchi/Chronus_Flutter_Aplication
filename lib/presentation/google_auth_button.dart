import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GoogleAuthButton extends StatelessWidget {
  final String buttonText;
  final Function googleLogInAction;

  GoogleAuthButton({
    @required this.buttonText,
    this.googleLogInAction,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 300.0,
      height: 42.0,
      onPressed: () => googleLogInAction(),
      color: Colors.red,
      child: Text('Log In with Google', style: TextStyle(color: Colors.white)),
    );
  }
}
