class ItemLists {
  int id;
  String title;
  String description;
  bool favorite;
  DateTime dateTime;
  static const String TABLENAME = "todos";

  ItemLists({
    this.id,
    this.title,
    this.description,
    this.favorite,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'favorite': favorite,
      'datetime': dateTime,
    };
  }
}
