import 'package:hive/hive.dart';

part 'cache_time.g.dart';

@HiveType(typeId: 10)
class CacheTime extends HiveObject {
  @HiveField(1)
  final DateTime lastUpdated;

  CacheTime({required this.lastUpdated});
}
