import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ent.dart';
import 'length.dart';

part 'step.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Step extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "number")
  int? number;
  @HiveField(2)
  @JsonKey(name: "step")
  String? step;
  @HiveField(3)
  @JsonKey(name: "ingredients")
  List<Ent>? ingredients;
  @HiveField(4)
  @JsonKey(name: "equipment")
  List<Ent>? equipment;
  @HiveField(5)
  @JsonKey(name: "length")
  Length? length;

  Step({
    this.number,
    this.step,
    this.ingredients,
    this.equipment,
    this.length,
  });

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}
