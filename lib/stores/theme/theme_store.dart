import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:project_w2o/constants/app_theme.dart';
import 'package:project_w2o/data/repository.dart';
import 'package:project_w2o/stores/error/error_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  final String TAG = "_ThemeStore";

  // repository instance
  final Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Key key = UniqueKey();

  static ThemeData theme = ThemeData.light();

  // store variables:-----------------------------------------------------------
  @observable
  bool _darkMode = false;

  // getters:-------------------------------------------------------------------
  bool get darkMode => _darkMode;

  // constructor:---------------------------------------------------------------
  _ThemeStore(Repository repository) : this._repository = repository {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Future changeBrightnessToDark(bool value) async {
    _darkMode = value;
    await _repository.changeBrightnessToDark(value);
  }

  // general methods:-----------------------------------------------------------
  Future init() async {
    _darkMode = await _repository?.isDarkMode ?? false;
  }

  bool isPlatformDark(BuildContext context) =>
      MediaQuery.platformBrightnessOf(context) == Brightness.dark;

  void setKey(value) {
    key = value;
//    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
//    notifyListeners();
  }

  void setTheme(value, c) {
    theme = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('theme', c).then((val) {
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: c == 'dark' ? themeDataDark.backgroundColor : themeData.backgroundColor,
          statusBarIconBrightness: c == 'dark' ? Brightness.light : Brightness.dark,
        ));
      });
    });
//    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData themeData;
    String set = prefs.getString('theme') == null ? 'light' : prefs.getString('theme');

    if (set == 'light') {
      themeData = themeData;
      setTheme(themeData, 'light');
    } else {
      themeData = themeDataDark;
      setTheme(themeDataDark, 'dark');
    }

    return themeData;
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
