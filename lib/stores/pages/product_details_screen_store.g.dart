// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductDetailsScreenStore on _ProductDetailsScreenStore, Store {
  final _$optionCheckedAtom =
      Atom(name: '_ProductDetailsScreenStore.optionChecked');

  @override
  bool get optionChecked {
    _$optionCheckedAtom.context.enforceReadPolicy(_$optionCheckedAtom);
    _$optionCheckedAtom.reportObserved();
    return super.optionChecked;
  }

  @override
  set optionChecked(bool value) {
    _$optionCheckedAtom.context.conditionallyRunInAction(() {
      super.optionChecked = value;
      _$optionCheckedAtom.reportChanged();
    }, _$optionCheckedAtom, name: '${_$optionCheckedAtom.name}_set');
  }

  final _$amountItemAtom = Atom(name: '_ProductDetailsScreenStore.amountItem');

  @override
  int get amountItem {
    _$amountItemAtom.context.enforceReadPolicy(_$amountItemAtom);
    _$amountItemAtom.reportObserved();
    return super.amountItem;
  }

  @override
  set amountItem(int value) {
    _$amountItemAtom.context.conditionallyRunInAction(() {
      super.amountItem = value;
      _$amountItemAtom.reportChanged();
    }, _$amountItemAtom, name: '${_$amountItemAtom.name}_set');
  }

  final _$_ProductDetailsScreenStoreActionController =
      ActionController(name: '_ProductDetailsScreenStore');

  @override
  void setCheckItemOption(bool value) {
    final _$actionInfo =
        _$_ProductDetailsScreenStoreActionController.startAction();
    try {
      return super.setCheckItemOption(value);
    } finally {
      _$_ProductDetailsScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addProductToCart(int idOption, String nameOption) {
    final _$actionInfo =
        _$_ProductDetailsScreenStoreActionController.startAction();
    try {
      return super.addProductToCart(idOption, nameOption);
    } finally {
      _$_ProductDetailsScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProductToCart(int idOption, String nameOption) {
    final _$actionInfo =
        _$_ProductDetailsScreenStoreActionController.startAction();
    try {
      return super.removeProductToCart(idOption, nameOption);
    } finally {
      _$_ProductDetailsScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementItem() {
    final _$actionInfo =
        _$_ProductDetailsScreenStoreActionController.startAction();
    try {
      return super.incrementItem();
    } finally {
      _$_ProductDetailsScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementItem() {
    final _$actionInfo =
        _$_ProductDetailsScreenStoreActionController.startAction();
    try {
      return super.decrementItem();
    } finally {
      _$_ProductDetailsScreenStoreActionController.endAction(_$actionInfo);
    }
  }
}
