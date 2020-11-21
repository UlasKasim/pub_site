import 'package:flutter/material.dart';

void pageChangePush(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void pageChangeRemoveUntil(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => page),
      (Route<dynamic> route) => false);
}

void pageChangePushNamed(BuildContext context, String routeName, {Object args}) {
  Navigator.of(context).pushNamed(routeName, arguments: args);
}

void pageChangeNamedRemoveUntil(BuildContext context, String routeName, {Object args}) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: args);
}

void goBack(BuildContext context) {
  Navigator.of(context).pop();
}
