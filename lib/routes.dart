import 'package:flutter/material.dart';
import 'package:project_w2o/ui/base/base.dart';

import 'ui/home/home.dart';
import 'ui/login/login.dart';
import 'ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String base = '/base';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    base: (BuildContext context) => BaseScreen(),
    home: (BuildContext context) => HomeScreen(),
  };
}
