import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:project_w2o/data/sharedpref/constants/preferences.dart';
import 'package:project_w2o/models/item_data/item_data.dart';
import 'package:project_w2o/models/item_data/item_data_list.dart';
import 'package:project_w2o/routes.dart';
import 'package:project_w2o/stores/form/form_store.dart';
import 'package:project_w2o/utils/device/device_utils.dart';
import 'package:project_w2o/widgets/progress_indicator_widget.dart';
import 'package:project_w2o/widgets/textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

var formatMoney = new NumberFormat.currency(locale: 'pt_BR', symbol: '');

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String baseUrl = "http://testemobile.w2o.com.br";

  ItemDataList _items;

  final LocalAuthentication auth = LocalAuthentication();

  List<BiometricType> _availableBiometrics;

  String dropdownValue = 'Selecione uma opção';
  DateTime selectedDate = DateTime.now();

  TextEditingController _nameItemController = TextEditingController();
  TextEditingController _descriptionItemController = TextEditingController();
  TextEditingController _categoryItemController = TextEditingController();
  MoneyMaskedTextController _valueItemController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  TextEditingController _dateItemController = new TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  final _formStore = FormStore();
  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _verifyAuthentication();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildList() {
    if (_items != null) {
      return _items.itemDataList.length != 0
          ? RefreshIndicator(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _items.itemDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      ItemDataModel item = _items.itemDataList[index];

                      return _cardListTile(item);
                    },
                  ),
                ),
              ),
              onRefresh: _getItems,
            )
          : Container(
              child: ProgressIndicatorWidget(),
            );
    } else {
      return Container(
        child: ProgressIndicatorWidget(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      body: _buildList(),
      floatingActionButton: FutureBuilder<dynamic>(
        future: _verifyNetwork(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Form(
                      key: _formKey,
                      child: AlertDialog(
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CircleAvatar(
                                  child: Icon(Icons.close),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                _buildNameItemField(),
                                SizedBox(height: 20.0),
                                _buildDescriptionItemField(),
                                SizedBox(height: 20.0),
                                _buildCategoryItemField(context),
                                SizedBox(height: 20.0),
                                _buildValueItemField(),
                                SizedBox(height: 20.0),
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: _buildDateItemField(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: RaisedButton(
                                    child: Text("Salvar"),
                                    onPressed: () {
                                      _submitForm(
                                        _formStore.nameItem,
                                        _formStore.descriptionItem,
                                        _formStore.categoryItem,
                                        _formStore.valueItem,
                                        _dateItemController.text,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Card _cardListTile(ItemDataModel itemDataModel) {
    return Card(
      child: ExpansionTile(
        title: Text(
          itemDataModel.name,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                r"R$ " + itemDataModel.value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                itemDataModel.date,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () async {
                      AlertDialog alert = AlertDialog(
                        title: Text("Remover item"),
                        content: Text("Tem certeza que deseja remover este item?"),
                        actions: [
                          cancelButton(),
                          deleteButton(itemDataModel.id),
                        ],
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                  ),
                ),
                Text(
                  itemDataModel.name,
                  style: TextStyle(
//                height: 3.50,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  itemDataModel.description,
                  style: TextStyle(
//                height: 3.50,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ButtonTheme(
                          minWidth: 20.0,
                          height: 20.0,
                          child: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              DateTime startDate;
                              DateTime endDate;

                              final DateTime startDatePicked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1901, 1),
                                  lastDate: DateTime(2100));
                              if (startDatePicked != null) {
                                setState(() {
                                  startDate = startDatePicked;
                                });
                              }

                              final DateTime endDatePicked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1901, 1),
                                  lastDate: DateTime(2100));
                              if (endDatePicked != null) {
                                setState(() {
                                  endDate = endDatePicked;
                                });
                              }

                              Event event = Event(
                                title: itemDataModel.name,
                                startDate: startDate,
                                endDate: endDate,
                              );

                              Add2Calendar.addEvent2Cal(event).then(
                                (success) {
                                  scaffoldState.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(success
                                          ? 'Sucesso! O item foi salvo no calendário.'
                                          : 'Ops! Houve um erro ao salvar o item no calendário'),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: ButtonTheme(
                          minWidth: 20.0,
                          height: 20.0,
                          child: IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () async {
                              var response =
                                  await FlutterShareMe().shareToWhatsApp(msg: itemDataModel.name);
                              if (response == 'success') {
                                print('SUCCESS ON SHARE ITEM');
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget deleteButton(int id) {
    return FlatButton(
      child: Text("Continuar"),
      onPressed: () {
        _deleteRequestAPI(id);
//        if (status == "success") {
//          _showSuccessMessage("O item foi removido.");
//        } else {
//          _showErrorMessage("Ops! Houve um erro ao remover o item.");
//        }

        Navigator.of(context).pop();
      },
    );
  }

  Future<bool> _verifyNetwork() async {
    bool hasConnection = false;

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      hasConnection = true;
    }

    return hasConnection;
  }

  Widget _buildNameItemField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: "Nome",
          isIcon: false,
          inputType: TextInputType.text,
          textController: _nameItemController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _formStore.setNameItem(_nameItemController.text);
          },
          hintColor: Colors.grey,
          errorText: _formStore.formErrorStore.nameItem,
        );
      },
    );
  }

  Widget _buildDescriptionItemField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: "Descrição",
          isIcon: false,
          inputType: TextInputType.multiline,
          textController: _descriptionItemController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _formStore.setDescriptionItem(_descriptionItemController.text);
          },
          hintColor: Colors.grey,
          errorText: _formStore.formErrorStore.descriptionItem,
        );
      },
    );
  }

  Widget _buildCategoryItemField(BuildContext context) {
    return DropDownFormField(
      titleText: 'Selecione a categoria',
      hintText: '',
      value: _categoryItemController.text,
      onSaved: (value) {
        setState(() {
          _formStore.setCategoryItem(_categoryItemController.text);
        });
      },
      onChanged: (value) {
        setState(() {
          _formStore.setCategoryItem(_categoryItemController.text);
        });
      },
      dataSource: [
        {
          "display": "Entrada",
          "value": "Entrada",
        },
        {
          "display": "Saída",
          "value": "Saída",
        },
        {
          "display": "Transferência",
          "value": "Transferência",
        },
        {
          "display": "Outros",
          "value": "Outros",
        },
      ],
      textField: "display",
      valueField: "value",
    );
  }

  Widget _buildValueItemField() {
    return TextFieldWidget(
      hint: "Valor",
      isIcon: false,
      inputType: TextInputType.number,
      textController: _valueItemController,
      inputAction: TextInputAction.next,
      onChanged: (value) {
        _formStore.setValueItem(_valueItemController.text);
      },
      hintColor: Colors.grey,
      errorText: _formStore.formErrorStore.valueItem,
    );
  }

  Widget _buildDateItemField() {
    return TextFieldWidget(
      hint: "Data",
      isIcon: false,
      inputType: TextInputType.datetime,
      textController: _dateItemController,
      inputAction: TextInputAction.next,
      onChanged: (value) {
        _formStore.setDateItem(_dateItemController.text);
      },
      hintColor: Colors.grey,
      errorText: _formStore.formErrorStore.dateItem,
    );
  }

  void _submitForm(String name, String description, String category, String value, String date) {
    SharedPreferences.getInstance().then((prefs) {
      String hash = prefs.getString(Preferences.authToken);

      if (hash != null) {
        Map<String, dynamic> data = {
          "hash": hash,
          "nome": name,
          "descricao": description,
          "category": category,
          "valor": value,
          "data": date,
        };

        if (_formStore.canAddItem) {
          DeviceUtils.hideKeyboard(context);

          _postRequestAPI(data);
        } else {
          _showErrorMessage('Ops, preencha todos os campos!');
        }

        Navigator.of(context).pop();
      }
    });
  }

  Future<void> _getItems() async {
    setState(() {
      _getRequestAPI();
    });
  }

  Future<void> _verifyAuthentication() async {
    SharedPreferences.getInstance().then((prefs) {
      String hash = prefs.getString(Preferences.authToken);
      if (hash != null) {
        _getAvailableBiometrics();
      } else {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool(Preferences.isLoggedIn, false);
        });

        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
      }
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      print(availableBiometrics);
      _availableBiometrics = availableBiometrics;

      if (_availableBiometrics != null) {
        _authenticate();
      }
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Verifique se é você mesmo', useErrorDialogs: true, stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      if (authenticated) {
        _getRequestAPI();
      }
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        var parsedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

        _dateItemController.value = TextEditingValue(text: parsedDate.toString());
      });
  }

// REQUESTS TO API
  Future<void> _getRequestAPI() async {
    try {
      SharedPreferences.getInstance().then((prefs) async {
        String hash = prefs.getString(Preferences.authToken);
        var connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          final response = await Dio().get("$baseUrl/item/lista", queryParameters: {"hash": hash});

          setState(() {
            _items = ItemDataList.fromJson(response.data['lista']);

            print('REQUEST GET SUCCESS');
          });
        }
      });
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);

      if (e.response.statusCode == 401) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool(Preferences.isLoggedIn, false);
        });

        Future.delayed(Duration(milliseconds: 0), () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
        });
      }
    }
  }

  Future<void> _postRequestAPI(Map<String, dynamic> data) async {
    try {
      await Dio().post("$baseUrl/item/novo", queryParameters: data);

      setState(() {
        print('REQUEST POST SUCCESS');

        _getRequestAPI();
      });
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);

      if (e.response.statusCode == 401) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool(Preferences.isLoggedIn, false);
        });

        Future.delayed(Duration(milliseconds: 0), () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
        });
      }
    }
  }

  Future<void> _deleteRequestAPI(int id) async {
    try {
      SharedPreferences.getInstance().then((prefs) async {
        String hash = prefs.getString(Preferences.authToken);
        var connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          String castedId = id.toString();

          await Dio().delete("$baseUrl/item/delete/$castedId", data: {"hash": hash});

          setState(() {
            print('REQUEST DELETE SUCCESS');
            _getRequestAPI();
          });
        }
      });
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);

      if (e.response.statusCode == 401) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool(Preferences.isLoggedIn, false);
        });

        Future.delayed(Duration(milliseconds: 0), () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
        });
      }
    }
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: "Ops! Houve um erro interno.",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  _showSuccessMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: "Sucesso! Sua ação foi realizada.",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}
