import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_w2o/data/sharedpref/constants/preferences.dart';
import 'package:project_w2o/routes.dart';
import 'package:project_w2o/widgets/app_icon_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: AppIconWidget(image: 'assets/images/logo-w2o.png')),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences.getInstance().then((prefs) {
      String hash = prefs.getString(Preferences.authToken);
      if (hash != null) {
        Navigator.of(context).pushReplacementNamed(Routes.base);
      } else {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool(Preferences.isLoggedIn, false);
        });

        Navigator.of(context).pushReplacementNamed(Routes.login);
      }
    });
  }
}
