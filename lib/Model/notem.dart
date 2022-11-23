class Notes {
  int? id;
  String title;
  String description;

  Notes({this.id, required this.title, required this.description});

  Notes.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        description = res["description"];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }
}
