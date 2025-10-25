import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '/models/step.dart';

part 'analyzed_instruction.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class AnalyzedInstruction extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "name")
  String? name;
  @HiveField(2)
  @JsonKey(name: "steps")
  List<Step>? steps;

  AnalyzedInstruction({
    this.name,
    this.steps,
  });

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedInstructionFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyzedInstructionToJson(this);
}
