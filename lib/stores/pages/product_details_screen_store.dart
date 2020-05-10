import 'package:mobx/mobx.dart';

part 'product_details_screen_store.g.dart';

class ProductDetailsScreenStore = _ProductDetailsScreenStore with _$ProductDetailsScreenStore;

abstract class _ProductDetailsScreenStore with Store {
  final List<CombinationsOptionsChecked> _combinationsOptionsChecked = [];

  @observable
  bool optionChecked = false;

  @observable
  int amountItem = 0;

  @action
  void setCheckItemOption(bool value) {
    print("CHECK ITEM - $value");
    optionChecked = value;
  }

  @action
  void addProductToCart(int idOption, String nameOption) {
    _combinationsOptionsChecked.add(CombinationsOptionsChecked(
      id: idOption,
      name: nameOption,
    ));
  }

  @action
  void removeProductToCart(int idOption, String nameOption) {
    _combinationsOptionsChecked.remove(CombinationsOptionsChecked(
      id: idOption,
      name: nameOption,
    ));
  }

  @action
  void incrementItem() {
    amountItem++;
  }

  @action
  void decrementItem() {
    if (amountItem >= 1) {
      amountItem--;
    }
  }
}

class CombinationsOptionsChecked {
  final int id;
  final String name;

  CombinationsOptionsChecked({this.id, this.name});

  factory CombinationsOptionsChecked.fromJson(Map<String, dynamic> parsedJson) {
    return CombinationsOptionsChecked(id: parsedJson['id'], name: parsedJson['name']);
  }
}
