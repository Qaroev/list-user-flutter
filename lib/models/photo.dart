import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
part 'photo.g.dart';

@HiveType(typeId: 3)
class Photo extends HiveObject {
  @HiveField(0)
  int albumId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String title;

  @HiveField(3)
  String url;

  @HiveField(4)
  String thumbnailUrl;

  @HiveField(5)
  Uint8List? fullBytes;

  @HiveField(6)
  Uint8List? thumbnailBytes;

  Photo(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  Photo.fromJson(Map json)
      : this.albumId = json['albumId'],
        this.id = json['id'],
        this.title = json['title'],
        this.url = json['url'],
        this.thumbnailUrl = json['thumbnailUrl'];
}