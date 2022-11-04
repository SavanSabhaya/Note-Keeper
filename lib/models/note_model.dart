class Note {
  final int? id;
  final String title;
  final String description;
  Note({this.id, required this.title, required this.description});

  factory Note.fromjson(Map<String, dynamic> json) => Note(
      id: json['id'], title: json['title'], description: json['description']);

  Map<String, dynamic> tojson() =>
      {'id': id, 'title': title, 'description': description};
}
