import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:project_w2o/data/sharedpref/constants/preferences.dart';
import 'package:project_w2o/stores/error/error_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _FormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => user, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => nameItem, validateNameItem),
      reaction((_) => descriptionItem, validateDescriptionItem),
      reaction((_) => categoryItem, validateCategoryItem),
      reaction((_) => valueItem, validateValueItem),
      reaction((_) => dateItem, validateDateItem),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String user = '';

  @observable
  String password = '';

  @observable
  String nameItem = '';

  @observable
  String descriptionItem = '';

  @observable
  String categoryItem = '';

  @observable
  String valueItem = '';

  @observable
  String dateItem = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canLogin => !formErrorStore.hasErrorsInLogin && user.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister && user.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canForgetPassword => !formErrorStore.hasErrorInForgotPassword && user.isNotEmpty;

  @computed
  bool get canAddItem =>
      !formErrorStore.hasErrorsInAddItem &&
      nameItem.isNotEmpty &&
      descriptionItem.isNotEmpty &&
      categoryItem.isNotEmpty &&
      valueItem.isNotEmpty &&
      dateItem.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    user = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setNameItem(String value) {
    nameItem = value;
  }

  @action
  void setDescriptionItem(String value) {
    descriptionItem = value;
  }

  @action
  void setCategoryItem(String value) {
    categoryItem = value;
  }

  @action
  void setValueItem(String value) {
    valueItem = value;
  }

  @action
  void setDateItem(String value) {
    dateItem = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.user = "O campo 'usuário' não pode estar vazio.";
    } else {
      formErrorStore.user = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "O campo 'senha' não pode estar vazio.";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateNameItem(String value) {
    if (value.isEmpty) {
      formErrorStore.nameItem = "O campo 'nome' não pode estar vazio.";
    } else {
      formErrorStore.nameItem = null;
    }
  }

  @action
  void validateDescriptionItem(String value) {
    if (value.isEmpty) {
      formErrorStore.descriptionItem = "O campo 'descrição' não pode estar vazio.";
    } else {
      formErrorStore.descriptionItem = null;
    }
  }

  @action
  void validateCategoryItem(String value) {
    if (value.isEmpty) {
      formErrorStore.categoryItem = "O campo 'categoria' não pode estar vazio.";
    } else {
      formErrorStore.categoryItem = null;
    }
  }

  @action
  void validateValueItem(String value) {
    if (value.isEmpty) {
      formErrorStore.valueItem = "O campo 'valor' não pode estar vazio.";
    } else {
      formErrorStore.valueItem = null;
    }
  }

  @action
  void validateDateItem(String value) {
    if (value.isEmpty) {
      formErrorStore.valueItem = "O campo 'data' não pode estar vazio.";
    } else {
      formErrorStore.valueItem = null;
    }
  }

  @action
  Future login() async {
    loading = true;

    try {
      print(user);
      print(password);

      final response = await Dio().post("http://testemobile.w2o.com.br/login/login",
          queryParameters: {"login": user, "senha": password});

      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(Preferences.authToken, response.data['hash']);
      });

      loading = false;
      success = true;
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);

      errorStore.errorMessage = e.message.toString();

      loading = false;
      success = false;
    }
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    loading = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(user);

    validateNameItem(nameItem);
    validateDescriptionItem(descriptionItem);
    validateCategoryItem(categoryItem);
    validateValueItem(valueItem);
    validateDateItem(dateItem);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String user;

  @observable
  String password;

  @observable
  String nameItem = '';

  @observable
  String descriptionItem = '';

  @observable
  String categoryItem = '';

  @observable
  String valueItem = '';

  @observable
  String dateItem = '';

  @computed
  bool get hasErrorsInLogin => user != null || password != null;

  @computed
  bool get hasErrorsInRegister => user != null || password != null;

  @computed
  bool get hasErrorInForgotPassword => user != null;

  @computed
  bool get hasErrorsInAddItem =>
      nameItem != null ||
      descriptionItem != null ||
      categoryItem != null ||
      valueItem != null ||
      dateItem != null;
}
