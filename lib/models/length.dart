import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'length.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class Length extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "number")
  int? number;
  @HiveField(2)
  @JsonKey(name: "unit")
  String? unit;

  Length({
    this.number,
    this.unit,
  });

  factory Length.fromJson(Map<String, dynamic> json) => _$LengthFromJson(json);

  Map<String, dynamic> toJson() => _$LengthToJson(this);
}
