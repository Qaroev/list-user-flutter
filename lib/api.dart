
import 'dart:convert';

import 'package:fortestapp/models/photo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import 'models/album.dart';
import 'models/comment.dart';
import 'models/user.dart';
import 'models/post.dart';

Future<List<User>> getAllUsers() async {
  final box = Hive.box<User>('users');
  if (box.values.length != 0) return box.values.toList();
  final responce =
  await get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  List body = jsonDecode(responce.body);
  final newValues = body.map((e) => User.fromJson(e)).toList();
  box.addAll(newValues);
  return newValues;
}

Future<List<Post>> getUserPosts(int userId) async {
  final box = Hive.box<Post>('posts');
  final values =
  box.values.where((element) => element.userId == userId).toList();
  if (values.length != 0) return values;
  final responce = await get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=$userId'));
  List body = jsonDecode(responce.body);
  final newValues = body.map((e) => Post.fromJson(e)).toList();
  box.addAll(newValues);
  return newValues;
}

Future<List<Album>> getUserAlbums(int userId) async {
  final box = Hive.box<Album>('albums');
  final values =
  box.values.where((element) => element.userId == userId).toList();
  if (values.length != 0) return values;
  final responce = await get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums?userId=$userId'));
  List body = jsonDecode(responce.body);
  final newValues = body.map((e) => Album.fromJson(e)).toList();
  box.addAll(newValues);
  return newValues;
}

Future<List<Photo>> getAlbumPhotos(int albumId) async {
  final box = Hive.box<Photo>('photos');
  final values =
  box.values.where((element) => element.albumId == albumId).toList();
  if (values.length != 0) return values;
  final responce = await get(Uri.parse(
      'https://jsonplaceholder.typicode.com/photos?albumId=$albumId'));
  List body = jsonDecode(responce.body);
  final newValues = body.map((e) => Photo.fromJson(e)).toList();
  box.addAll(newValues);
  return newValues;
}

Future<List<Comment>> getPostComments(int postId) async {
  final box = Hive.box<Comment>('comments');
  final values =
  box.values.where((element) => element.postId == postId).toList();
  if (values.length != 0) return values;
  final responce = await get(Uri.parse(
      'https://jsonplaceholder.typicode.com/comments?postId=$postId'));
  List body = jsonDecode(responce.body);
  final newValues = body.map((e) => Comment.fromJson(e)).toList();
  box.addAll(newValues);
  return newValues;
}

Future postComment({
  required int postId,
  required String name,
  required String email,
  required String text,
}) async {
  final box = Hive.box<Comment>('comments');
  final responce = await post(
    Uri.parse('https://jsonplaceholder.typicode.com/comments'),
    body: {
      'postId': postId.toString(),
      'name': name,
      'email': email,
      'body': text,
    },
  );
  final body = jsonDecode(responce.body);
  box.add(Comment(postId, body['id'], name, email, text));
}