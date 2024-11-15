import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "cacheConfig.dart";


@JsonSerializable()
class Profile {
  Profile();

  User? user;
  String? token;
  late num theme;
  CacheConfig? cache;
  String? lastLogin;
  String? locale;

  static Profile? fromJson(jsonDecode) {
    return null;
  }

  Object? toJson() {
    return null;
  }
  

}
