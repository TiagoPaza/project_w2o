class ItemDataModel {
  int id;
  String name;
  String date;
  String value;
  String category;
  String description;

  ItemDataModel({
    this.id,
    this.name,
    this.date,
    this.value,
    this.category,
    this.description,
  });

  factory ItemDataModel.fromMap(Map<String, dynamic> json) => ItemDataModel(
        id: json['id'],
        name: json['nome'],
        date: json['data'],
        value: json['valor'],
        category: json['categoria'],
        description: json['descricao'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "date": date,
        "value": value,
        "category": category,
        "description": description,
      };
}
