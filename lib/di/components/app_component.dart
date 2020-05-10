import 'package:inject/inject.dart';
import 'package:project_w2o/data/repository.dart';
import 'package:project_w2o/di/modules/local_module.dart';
import 'package:project_w2o/di/modules/preference_module.dart';
import 'package:project_w2o/main.dart';

import 'app_component.inject.dart' as g;

/// The top level injector that stitches together multiple app features into
/// a complete app.
@Injector(const [LocalModule, PreferenceModule])
abstract class AppComponent {
  @provide
  MyApp get app;

  static Future<AppComponent> create(
    LocalModule localModule,
    PreferenceModule preferenceModule,
  ) async {
    return await g.AppComponent$Injector.create(
      localModule,
      preferenceModule,
    );
  }

  /// An accessor to RestClient object that an application may use.
  @provide
  Repository getRepository();
}
