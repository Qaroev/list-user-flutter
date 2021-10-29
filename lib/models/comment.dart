import 'package:hive_flutter/hive_flutter.dart';
part 'comment.g.dart';

@HiveType(typeId: 4)
class Comment extends HiveObject {
  @HiveField(0)
  int postId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String email;

  @HiveField(4)
  String body;

  Comment(this.postId, this.id, this.name, this.email, this.body);

  Comment.fromJson(Map json)
      : this.postId = json['postId'],
        this.id = json['id'],
        this.name = json['name'],
        this.email = json['email'],
        this.body = json['body'];
}