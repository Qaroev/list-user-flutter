import 'package:flutter/material.dart';
import 'package:fortestapp/pages/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'models/album.dart';
import 'models/comment.dart';
import 'models/photo.dart';
import 'models/post.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<Album>('albums');
  await Hive.openBox<Comment>('comments');
  await Hive.openBox<Photo>('photos');
  await Hive.openBox<Post>('posts');
  await Hive.openBox<User>('users');
  runApp(
    MaterialApp(
      home: UsersPage(),
      theme: ThemeData(
        // brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.green,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: 18,
                ),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              overlayColor: MaterialStateProperty.all(Colors.blueGrey[50])),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.blueGrey[50],
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          headline1: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
