import 'package:flutter/material.dart';
import 'package:fortestapp/api.dart';
import 'package:fortestapp/models/post.dart';
import 'package:fortestapp/models/user.dart';
import 'package:fortestapp/pages/post_details_page.dart';
import 'package:fortestapp/widget/post_preview.dart';

class PostsPage extends StatelessWidget {
  final User user;
  PostsPage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "${user.username}'s posts",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: FutureBuilder(
        future: getUserPosts(user.id),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PostPreview(
                  snapshot.data![index],
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PostDetailsPage(snapshot.data![index]))),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
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
}