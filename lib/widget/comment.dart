import 'package:flutter/material.dart';
import 'package:fortestapp/models/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  CommentCard(this.comment);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blueGrey[50]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${comment.id} ${comment.name}',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.black87),
          ),
          Text(
            comment.email,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.black54),
          ),
          Text(comment.body),
        ],
      ),
    );
  }
}