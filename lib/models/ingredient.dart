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
  @JsonKey(name: "name")
  String? name;
  @HiveField(5)
  @JsonKey(name: "nameClean")
  String? nameClean;
  @HiveField(6)
  @JsonKey(name: "original")
  String? original;
  @HiveField(7)
  @JsonKey(name: "originalName")
  String? originalName;
  @HiveField(8)
  @JsonKey(name: "amount")
  double? amount;
  @HiveField(9)
  @JsonKey(name: "unit")
  String? unit;
  @HiveField(10)
  @JsonKey(name: "meta")
  List<String>? meta;
  @HiveField(11)
  @JsonKey(name: "measures")
  Measures? measures;

  Ingredient({
    this.id,
    this.aisle,
    this.image,
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
