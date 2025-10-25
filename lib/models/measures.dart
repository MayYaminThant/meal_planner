import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'metric.dart';

part 'measures.g.dart';

@HiveType(typeId: 7)
@JsonSerializable()
class Measures extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "us")
  Metric? us;
  @HiveField(2)
  @JsonKey(name: "metric")
  Metric? metric;

  Measures({
    this.us,
    this.metric,
  });

  factory Measures.fromJson(Map<String, dynamic> json) =>
      _$MeasuresFromJson(json);

  Map<String, dynamic> toJson() => _$MeasuresToJson(this);
}
