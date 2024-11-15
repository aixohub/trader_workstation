import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  User();

  late String login;
  late String avatar_url;
  late String type;
  String? name;
  String? company;
  String? blog;
  String? location;
}
