import 'package:project_w2o/models/item_data/item_data.dart';

class ItemDataList {
  List<ItemDataModel> itemDataList;

  ItemDataList({
    this.itemDataList,
  });

  factory ItemDataList.fromJson(List<dynamic> json) {
    List<ItemDataModel> itemsData = List<ItemDataModel>();

    itemsData = json.map((itemData) => ItemDataModel.fromMap(itemData)).toList();

    return ItemDataList(
      itemDataList: itemsData,
    );
  }
}
