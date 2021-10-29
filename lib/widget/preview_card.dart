import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fortestapp/api.dart';
import 'package:fortestapp/models/album.dart';
import 'package:fortestapp/models/photo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlbumPreview extends StatefulWidget {
  final Album album;
  final void Function()? onTap;
  AlbumPreview(this.album, {this.onTap});

  @override
  _AlbumPreviewState createState() => _AlbumPreviewState();
}

class _AlbumPreviewState extends State<AlbumPreview> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAlbumPhotos(widget.album.id),
      builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.blueGrey[50]),
            child: ListTile(
              leading: FutureBuilder(
                future: _photo(snapshot.data![0]),
                builder: (context, AsyncSnapshot<Image> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return snapshot.data!;
                  else {
                    return CircularProgressIndicator(color: Colors.black);
                  }
                },
              ),
              title: Text(
                widget.album.title,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                snapshot.connectionState == ConnectionState.done ? snapshot.data![0].title : '...',
                overflow: TextOverflow.ellipsis,
              ),
              trailing: widget.onTap != null ? Icon(Icons.keyboard_arrow_right) : SizedBox.shrink(),
              onTap: widget.onTap,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<Image> _photo(Photo photo) async {
    final box = Hive.box<Photo>('photos');
    try {
      return Image.memory(box.values.firstWhere((e) => photo.id == e.id).thumbnailBytes!);
    } catch (e) {
      final ByteData imageData = await NetworkAssetBundle(Uri.parse(photo.thumbnailUrl)).load("");
      final Uint8List bytes = imageData.buffer.asUint8List();
      photo.thumbnailBytes = bytes;
      photo.save();
      return Image.memory(
        bytes,
      );
    }
  }
}