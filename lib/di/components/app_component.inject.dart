import 'app_component.dart' as _i1;
import '../modules/local_module.dart' as _i2;
import '../modules/preference_module.dart' as _i3;
import '../../data/sharedpref/shared_preference_helper.dart' as _i4;
import '../../data/repository.dart' as _i5;
import 'dart:async' as _i6;
import '../../main.dart' as _i7;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._(this._localModule, this._preferenceModule);

  final _i2.LocalModule _localModule;

  final _i3.PreferenceModule _preferenceModule;

  _i4.SharedPreferenceHelper _singletonSharedPreferenceHelper;

  _i5.Repository _singletonRepository;

  static _i6.Future<_i1.AppComponent> create(_i2.LocalModule localModule,
      _i3.PreferenceModule preferenceModule) async {
    final injector = AppComponent$Injector._(localModule, preferenceModule);

    return injector;
  }

  _i7.MyApp _createMyApp() => _i7.MyApp();
  _i5.Repository _createRepository() => _singletonRepository ??=
      _localModule.provideRepository(_createSharedPreferenceHelper());
  _i4.SharedPreferenceHelper _createSharedPreferenceHelper() =>
      _singletonSharedPreferenceHelper ??=
          _preferenceModule.provideSharedPreferenceHelper();
  @override
  _i7.MyApp get app => _createMyApp();
  @override
  _i5.Repository getRepository() => _createRepository();
}
