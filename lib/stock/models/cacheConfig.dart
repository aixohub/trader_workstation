import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CacheConfig {
  CacheConfig();

  late bool enable;
  late num maxAge;
  late num maxCount;
}
