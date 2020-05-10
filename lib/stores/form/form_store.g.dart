// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool> _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin)).value;
  Computed<bool> _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister)).value;
  Computed<bool> _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??=
          Computed<bool>(() => super.canForgetPassword))
      .value;
  Computed<bool> _$canAddItemComputed;

  @override
  bool get canAddItem =>
      (_$canAddItemComputed ??= Computed<bool>(() => super.canAddItem)).value;

  final _$userAtom = Atom(name: '_FormStore.user');

  @override
  String get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(String value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_FormStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$nameItemAtom = Atom(name: '_FormStore.nameItem');

  @override
  String get nameItem {
    _$nameItemAtom.context.enforceReadPolicy(_$nameItemAtom);
    _$nameItemAtom.reportObserved();
    return super.nameItem;
  }

  @override
  set nameItem(String value) {
    _$nameItemAtom.context.conditionallyRunInAction(() {
      super.nameItem = value;
      _$nameItemAtom.reportChanged();
    }, _$nameItemAtom, name: '${_$nameItemAtom.name}_set');
  }

  final _$descriptionItemAtom = Atom(name: '_FormStore.descriptionItem');

  @override
  String get descriptionItem {
    _$descriptionItemAtom.context.enforceReadPolicy(_$descriptionItemAtom);
    _$descriptionItemAtom.reportObserved();
    return super.descriptionItem;
  }

  @override
  set descriptionItem(String value) {
    _$descriptionItemAtom.context.conditionallyRunInAction(() {
      super.descriptionItem = value;
      _$descriptionItemAtom.reportChanged();
    }, _$descriptionItemAtom, name: '${_$descriptionItemAtom.name}_set');
  }

  final _$successAtom = Atom(name: '_FormStore.success');

  @override
  bool get success {
    _$successAtom.context.enforceReadPolicy(_$successAtom);
    _$successAtom.reportObserved();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.context.conditionallyRunInAction(() {
      super.success = value;
      _$successAtom.reportChanged();
    }, _$successAtom, name: '${_$successAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_FormStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<dynamic> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$forgotPasswordAsyncAction = AsyncAction('forgotPassword');

  @override
  Future<dynamic> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void setUserId(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setUserId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNameItem(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setNameItem(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescriptionItem(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setDescriptionItem(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateNameItem(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validateNameItem(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateDescriptionItem(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validateDescriptionItem(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool> _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??=
          Computed<bool>(() => super.hasErrorsInLogin))
      .value;
  Computed<bool> _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister))
      .value;
  Computed<bool> _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword))
      .value;
  Computed<bool> _$hasErrorsInAddItemComputed;

  @override
  bool get hasErrorsInAddItem => (_$hasErrorsInAddItemComputed ??=
          Computed<bool>(() => super.hasErrorsInAddItem))
      .value;

  final _$userAtom = Atom(name: '_FormErrorStore.user');

  @override
  String get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(String value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_FormErrorStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$nameItemAtom = Atom(name: '_FormErrorStore.nameItem');

  @override
  String get nameItem {
    _$nameItemAtom.context.enforceReadPolicy(_$nameItemAtom);
    _$nameItemAtom.reportObserved();
    return super.nameItem;
  }

  @override
  set nameItem(String value) {
    _$nameItemAtom.context.conditionallyRunInAction(() {
      super.nameItem = value;
      _$nameItemAtom.reportChanged();
    }, _$nameItemAtom, name: '${_$nameItemAtom.name}_set');
  }

  final _$descriptionItemAtom = Atom(name: '_FormErrorStore.descriptionItem');

  @override
  String get descriptionItem {
    _$descriptionItemAtom.context.enforceReadPolicy(_$descriptionItemAtom);
    _$descriptionItemAtom.reportObserved();
    return super.descriptionItem;
  }

  @override
  set descriptionItem(String value) {
    _$descriptionItemAtom.context.conditionallyRunInAction(() {
      super.descriptionItem = value;
      _$descriptionItemAtom.reportChanged();
    }, _$descriptionItemAtom, name: '${_$descriptionItemAtom.name}_set');
  }
}
