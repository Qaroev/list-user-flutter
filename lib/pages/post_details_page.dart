import 'package:flutter/material.dart';
import 'package:fortestapp/api.dart';
import 'package:fortestapp/models/comment.dart';
import 'package:fortestapp/models/post.dart';
import 'package:fortestapp/widget/comment.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  PostDetailsPage(this.post);

  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          'post #${post.id}',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: FutureBuilder(
        future: getPostComments(post.id),
        builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 10),
                    Text(post.body),
                    SizedBox(height: 10),
                    Text('comments:'),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CommentCard(snapshot.data![index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            builder: myBottomSheet,
                            isScrollControlled: true,
                          );
                        },
                        child: Text('Write a comment'),
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget myBottomSheet(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          10,
          10,
          10,
          MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Write a comment',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Email must be non empty';
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Name must be non empty';
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _commentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'Comment',
                ),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Comment must be non empty';
                  }
                },
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      postComment(
                          postId: post.id,
                          email: _emailController.text,
                          name: _nameController.text,
                          text: _commentController.text)
                          .then(
                            (_) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Success!'),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Text('Send comment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}