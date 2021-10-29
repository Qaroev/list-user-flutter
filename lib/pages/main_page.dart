import 'package:flutter/material.dart';
import 'package:fortestapp/api.dart';
import 'package:fortestapp/models/user.dart';
import 'package:fortestapp/widget/user.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users page',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: FutureBuilder(
        future: getAllUsers(),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Users(snapshot.data![index]);
              },
              separatorBuilder: (context, _) {
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