import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metric.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class Metric extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "amount")
  double? amount;
  @HiveField(2)
  @JsonKey(name: "unitShort")
  String? unitShort;
  @HiveField(3)
  @JsonKey(name: "unitLong")
  String? unitLong;

  Metric({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);

  Map<String, dynamic> toJson() => _$MetricToJson(this);
}
