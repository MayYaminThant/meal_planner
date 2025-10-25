// ignore_for_file: constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'measures.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class Ingredient extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "id")
  int? id;
  @HiveField(2)
  @JsonKey(name: "aisle")
  String? aisle;
  @HiveField(3)
  @JsonKey(name: "image")
  String? image;
  @HiveField(4)
  @JsonKey(name: "consistency")
  Consistency? consistency;
  @HiveField(5)
  @JsonKey(name: "name")
  String? name;
  @HiveField(6)
  @JsonKey(name: "nameClean")
  String? nameClean;
  @HiveField(7)
  @JsonKey(name: "original")
  String? original;
  @HiveField(8)
  @JsonKey(name: "originalName")
  String? originalName;
  @HiveField(9)
  @JsonKey(name: "amount")
  double? amount;
  @HiveField(10)
  @JsonKey(name: "unit")
  String? unit;
  @HiveField(11)
  @JsonKey(name: "meta")
  List<String>? meta;
  @HiveField(12)
  @JsonKey(name: "measures")
  Measures? measures;

  Ingredient({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.measures,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

enum Consistency {
  @JsonValue("LIQUID")
  LIQUID,
  @JsonValue("SOLID")
  SOLID
}

final consistencyValues =
    EnumValues({"LIQUID": Consistency.LIQUID, "SOLID": Consistency.SOLID});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
