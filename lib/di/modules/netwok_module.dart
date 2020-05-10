import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:project_w2o/data/network/constants/endpoints.dart';
import 'package:project_w2o/data/sharedpref/shared_preference_helper.dart';
import 'package:project_w2o/di/modules/preference_module.dart';

@module
class NetworkModule extends PreferenceModule {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkModule";

  // DI Providers:--------------------------------------------------------------
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (Options options) async {
            // getting shared pref instance
//            var prefs = await SharedPreferences.getInstance();

            // getting token
//            var token = prefs.getString(Preferences.authToken);
//
//            if (token != null) {
//              options.headers.putIfAbsent('Authorization', () => token);
//            } else {
//              print('Auth token is null');
//            }
          },
        ),
      );

    return dio;
  }
}
