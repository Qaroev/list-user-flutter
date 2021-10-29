import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String username;

  @HiveField(3)
  String email;

  @HiveField(4)
  Map<dynamic, dynamic> address;

  @HiveField(5)
  String phone;

  @HiveField(6)
  String website;

  @HiveField(7)
  Map<dynamic, dynamic> company;

  User(
      this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company,
      );

  User.fromJson(Map json)
      : this.id = json['id'],
        this.name = json['name'],
        this.username = json['username'],
        this.email = json['email'],
        this.address = json['address'],
        this.phone = json['phone'],
        this.website = json['website'],
        this.company = json['company'];
}