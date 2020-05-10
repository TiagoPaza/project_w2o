// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeStore on _ThemeStore, Store {
  final _$_darkModeAtom = Atom(name: '_ThemeStore._darkMode');

  @override
  bool get _darkMode {
    _$_darkModeAtom.context.enforceReadPolicy(_$_darkModeAtom);
    _$_darkModeAtom.reportObserved();
    return super._darkMode;
  }

  @override
  set _darkMode(bool value) {
    _$_darkModeAtom.context.conditionallyRunInAction(() {
      super._darkMode = value;
      _$_darkModeAtom.reportChanged();
    }, _$_darkModeAtom, name: '${_$_darkModeAtom.name}_set');
  }

  final _$changeBrightnessToDarkAsyncAction =
      AsyncAction('changeBrightnessToDark');

  @override
  Future<dynamic> changeBrightnessToDark(bool value) {
    return _$changeBrightnessToDarkAsyncAction
        .run(() => super.changeBrightnessToDark(value));
  }
}
