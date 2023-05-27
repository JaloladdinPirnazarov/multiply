
class ListModel{
  int id;
  String title;
  int isClicked;
  bool isDeleted = false;

  ListModel({required this.id, required this.title, required this.isClicked});

  factory ListModel.fromJson(Map<String, dynamic> json){
    return ListModel(id: json["id"] ,title: json["title"] ?? "empty", isClicked: json["is_clicked"] ?? 0);
  }

  toJson(){
    return {"title": title, "is_clicked": isClicked};
}
}