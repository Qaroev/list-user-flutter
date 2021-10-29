import 'package:flutter/material.dart';
import 'package:fortestapp/models/user.dart';
import 'package:fortestapp/pages/user_page.dart';

class Users extends StatelessWidget {
  final User user;
  Users(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).backgroundColor),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          child: Icon(
            Icons.person,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(
          user.username,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        subtitle: Text(
          user.name,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => UserPage(user)),
        ),
      ),
    );
  }
}