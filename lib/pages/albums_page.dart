import 'package:flutter/material.dart';
import 'package:fortestapp/api.dart';
import 'package:fortestapp/models/album.dart';
import 'package:fortestapp/models/user.dart';
import 'package:fortestapp/pages/album_details_page.dart';
import 'package:fortestapp/widget/preview_card.dart';

class AlbumsPage extends StatelessWidget {
  final User user;
  AlbumsPage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "${user.username}'s albums",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: FutureBuilder(
        future: getUserAlbums(user.id),
        builder: (context, AsyncSnapshot<List<Album>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              addAutomaticKeepAlives: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return AlbumPreview(
                  snapshot.data![index],
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AlbumDetailsPage(snapshot.data![index]))),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: snapshot.data!.length,
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
}