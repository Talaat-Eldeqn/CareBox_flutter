import 'package:flutter/material.dart';

enum NavigatorType { push, puchReplacement, pushAndRemoveUntil }

abstract class MyNavigator {
  static goTo(
    BuildContext context,
    Widget destination, {
    NavigatorType type = NavigatorType.push,
  }) {
    var pageRoute = MaterialPageRoute(builder: (_) => destination);

    switch (type) {
      case NavigatorType.push:
        return Navigator.push(context, pageRoute);
      case NavigatorType.puchReplacement:
        return Navigator.pushReplacement(context, pageRoute);
      case NavigatorType.pushAndRemoveUntil:
        return Navigator.pushAndRemoveUntil(
          context,
          pageRoute,
          (route) => false,
        );
    }
  }

  static goBack(context) => Navigator.pop(context);
}
