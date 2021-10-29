import 'package:hive/hive.dart';
part 'post.g.dart';

@HiveType(typeId: 1)
class Post extends HiveObject {
  @HiveField(0)
  int userId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String title;

  @HiveField(3)
  String body;

  Post(this.userId, this.id, this.title, this.body);

  Post.fromJson(Map json)
      : this.userId = json['userId'],
        this.id = json['id'],
        this.title = json['title'],
        this.body = json['body'];
}