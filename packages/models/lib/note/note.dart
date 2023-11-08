
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String?id;
  @HiveField(2)
  String? userId;
  @HiveField(3)
  String? title;
  @HiveField(4)
  String? content;
  @HiveField(5)
  DateTime? dateAdded;
  @HiveField(6)
  int? color;

  Note({this.id, this.userId, this.title, this.content,this.dateAdded});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    content = json['content'];
    dateAdded = DateTime.tryParse(json['dateAdded']);
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['content'] = content;

    return data;
  }
}