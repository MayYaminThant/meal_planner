// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'analyzed_instruction.dart';
import 'ingredient.dart';

part 'recipe.g.dart';

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

@HiveType(typeId: 1)
@JsonSerializable()
class Recipe extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "id")
  int? id;
  @HiveField(2)
  @JsonKey(name: "image")
  String? image;
  @HiveField(3)
  @JsonKey(name: "imageType")
  String? imageType;
  @HiveField(4)
  @JsonKey(name: "title")
  String? title;
  @HiveField(5)
  @JsonKey(name: "readyInMinutes")
  int? readyInMinutes;
  @HiveField(6)
  @JsonKey(name: "servings")
  int? servings;
  @HiveField(7)
  @JsonKey(name: "sourceUrl")
  String? sourceUrl;
  @HiveField(8)
  @JsonKey(name: "vegetarian")
  bool? vegetarian;
  @HiveField(9)
  @JsonKey(name: "vegan")
  bool? vegan;
  @HiveField(10)
  @JsonKey(name: "glutenFree")
  bool? glutenFree;
  @HiveField(11)
  @JsonKey(name: "dairyFree")
  bool? dairyFree;
  @HiveField(12)
  @JsonKey(name: "veryHealthy")
  bool? veryHealthy;
  @HiveField(13)
  @JsonKey(name: "cheap")
  bool? cheap;
  @HiveField(14)
  @JsonKey(name: "veryPopular")
  bool? veryPopular;
  @HiveField(15)
  @JsonKey(name: "sustainable")
  bool? sustainable;
  @HiveField(16)
  @JsonKey(name: "lowFodmap")
  bool? lowFodmap;
  @HiveField(17)
  @JsonKey(name: "weightWatcherSmartPoints")
  int? weightWatcherSmartPoints;
  @HiveField(18)
  @JsonKey(name: "gaps")
  String? gaps;
  @HiveField(19)
  @JsonKey(name: "preparationMinutes")
  int? preparationMinutes;
  @HiveField(20)
  @JsonKey(name: "cookingMinutes")
  int? cookingMinutes;
  @HiveField(21)
  @JsonKey(name: "aggregateLikes")
  int? aggregateLikes;
  @HiveField(22)
  @JsonKey(name: "healthScore")
  int? healthScore;
  @HiveField(23)
  @JsonKey(name: "creditsText")
  String? creditsText;
  @HiveField(24)
  @JsonKey(name: "license")
  String? license;
  @HiveField(25)
  @JsonKey(name: "sourceName")
  String? sourceName;
  @HiveField(26)
  @JsonKey(name: "pricePerServing")
  double? pricePerServing;
  @HiveField(27)
  @JsonKey(name: "extendedIngredients")
  List<Ingredient>? extendedIngredients;
  @HiveField(28)
  @JsonKey(name: "summary")
  String? summary;
  @HiveField(29)
  @JsonKey(name: "dishTypes")
  List<String>? dishTypes;
  @HiveField(30)
  @JsonKey(name: "diets")
  List<String>? diets;
  @HiveField(31)
  @JsonKey(name: "instructions")
  String? instructions;
  @HiveField(32)
  @JsonKey(name: "analyzedInstructions")
  List<AnalyzedInstruction>? analyzedInstructions;
  @HiveField(33)
  @JsonKey(name: "originalId")
  int? originalId;
  @HiveField(34)
  @JsonKey(name: "spoonacularScore")
  double? spoonacularScore;
  @HiveField(35)
  @JsonKey(name: "spoonacularSourceUrl")
  String? spoonacularSourceUrl;

  Recipe({
    this.id,
    this.image,
    this.imageType,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.lowFodmap,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.preparationMinutes,
    this.cookingMinutes,
    this.aggregateLikes,
    this.healthScore,
    this.creditsText,
    this.license,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
    this.summary,
    this.dishTypes,
    this.diets,
    this.instructions,
    this.analyzedInstructions,
    this.originalId,
    this.spoonacularScore,
    this.spoonacularSourceUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
