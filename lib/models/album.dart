import 'package:hive_flutter/hive_flutter.dart';
part 'album.g.dart';

@HiveType(typeId: 2)
class Album extends HiveObject {
  @HiveField(0)
  int userId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String title;

  Album(this.userId, this.id, this.title);

  Album.fromJson(Map json)
      : this.userId = json['userId'],
        this.id = json['id'],
        this.title = json['title'];
}