import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fortestapp/api.dart';
import 'package:fortestapp/models/album.dart';
import 'package:fortestapp/models/photo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlbumDetailsPage extends StatelessWidget {
  final Album album;
  AlbumDetailsPage(this.album);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          album.title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: FutureBuilder(
        future: getAlbumPhotos(album.id),
        builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PageView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        FutureBuilder(
                          future: _photo(snapshot.data![index]),
                          builder: (context, AsyncSnapshot<Image> snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.done)
                              return snapshot2.data!;
                            else {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: Colors.black),
                              );
                            }
                          },
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Text('${index + 1}/${snapshot.data!.length}'),
                        ),
                      ],
                    ),
                    Text(snapshot.data![index].title),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        },
      ),
    );
  }

  Future<Image> _photo(Photo photo) async {
    final box = Hive.box<Photo>('photos');
    try {
      return Image.memory(
          box.values.firstWhere((e) => photo.id == e.id).fullBytes!);
    } catch (e) {
      final ByteData imageData =
      await NetworkAssetBundle(Uri.parse(photo.url)).load("");
      final Uint8List bytes = imageData.buffer.asUint8List();
      photo.fullBytes = bytes;
      photo.save();
      return Image.memory(
        bytes,
      );
    }
  }
}