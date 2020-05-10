import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:inject/inject.dart';
import 'package:project_w2o/constants/app_theme.dart';
import 'package:project_w2o/constants/strings.dart';
import 'package:project_w2o/di/components/app_component.dart';
import 'package:project_w2o/di/modules/preference_module.dart';
import 'package:project_w2o/routes.dart';
import 'package:project_w2o/stores/theme/theme_store.dart';
import 'package:project_w2o/ui/base/base.dart';
import 'package:project_w2o/utils/locale/app_localization.dart';
import 'package:provider/provider.dart';

import 'di/modules/local_module.dart';

// global instance for app component
AppComponent appComponent;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) async {
    appComponent = await AppComponent.create(LocalModule(), PreferenceModule());
    runApp(appComponent.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(appComponent.getRepository());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>.value(value: _themeStore),
      ],
      child: Observer(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
            ],
            // Returns a locale which will be used by the app
            localeResolutionCallback: (locale, supportedLocales) =>
                // Check if the current device locale is supported
                supportedLocales.firstWhere(
                    (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
                    orElse: () => supportedLocales.first),
            home: BaseScreen(),
          );
        },
      ),
    );
  }
}
