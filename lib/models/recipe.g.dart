// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 1;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[1] as int?,
      image: fields[2] as String?,
      imageType: fields[3] as String?,
      title: fields[4] as String?,
      readyInMinutes: fields[5] as int?,
      servings: fields[6] as int?,
      sourceUrl: fields[7] as String?,
      vegetarian: fields[8] as bool?,
      vegan: fields[9] as bool?,
      glutenFree: fields[10] as bool?,
      dairyFree: fields[11] as bool?,
      veryHealthy: fields[12] as bool?,
      cheap: fields[13] as bool?,
      veryPopular: fields[14] as bool?,
      sustainable: fields[15] as bool?,
      lowFodmap: fields[16] as bool?,
      weightWatcherSmartPoints: fields[17] as int?,
      gaps: fields[18] as String?,
      preparationMinutes: fields[19] as int?,
      cookingMinutes: fields[20] as int?,
      aggregateLikes: fields[21] as int?,
      healthScore: fields[22] as int?,
      creditsText: fields[23] as String?,
      license: fields[24] as String?,
      sourceName: fields[25] as String?,
      pricePerServing: fields[26] as double?,
      extendedIngredients: (fields[27] as List?)?.cast<Ingredient>(),
      summary: fields[28] as String?,
      dishTypes: (fields[29] as List?)?.cast<String>(),
      diets: (fields[30] as List?)?.cast<String>(),
      instructions: fields[31] as String?,
      analyzedInstructions: (fields[32] as List?)?.cast<AnalyzedInstruction>(),
      originalId: fields[33] as int?,
      spoonacularScore: fields[34] as double?,
      spoonacularSourceUrl: fields[35] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(35)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.imageType)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.readyInMinutes)
      ..writeByte(6)
      ..write(obj.servings)
      ..writeByte(7)
      ..write(obj.sourceUrl)
      ..writeByte(8)
      ..write(obj.vegetarian)
      ..writeByte(9)
      ..write(obj.vegan)
      ..writeByte(10)
      ..write(obj.glutenFree)
      ..writeByte(11)
      ..write(obj.dairyFree)
      ..writeByte(12)
      ..write(obj.veryHealthy)
      ..writeByte(13)
      ..write(obj.cheap)
      ..writeByte(14)
      ..write(obj.veryPopular)
      ..writeByte(15)
      ..write(obj.sustainable)
      ..writeByte(16)
      ..write(obj.lowFodmap)
      ..writeByte(17)
      ..write(obj.weightWatcherSmartPoints)
      ..writeByte(18)
      ..write(obj.gaps)
      ..writeByte(19)
      ..write(obj.preparationMinutes)
      ..writeByte(20)
      ..write(obj.cookingMinutes)
      ..writeByte(21)
      ..write(obj.aggregateLikes)
      ..writeByte(22)
      ..write(obj.healthScore)
      ..writeByte(23)
      ..write(obj.creditsText)
      ..writeByte(24)
      ..write(obj.license)
      ..writeByte(25)
      ..write(obj.sourceName)
      ..writeByte(26)
      ..write(obj.pricePerServing)
      ..writeByte(27)
      ..write(obj.extendedIngredients)
      ..writeByte(28)
      ..write(obj.summary)
      ..writeByte(29)
      ..write(obj.dishTypes)
      ..writeByte(30)
      ..write(obj.diets)
      ..writeByte(31)
      ..write(obj.instructions)
      ..writeByte(32)
      ..write(obj.analyzedInstructions)
      ..writeByte(33)
      ..write(obj.originalId)
      ..writeByte(34)
      ..write(obj.spoonacularScore)
      ..writeByte(35)
      ..write(obj.spoonacularSourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] as String?,
      imageType: json['imageType'] as String?,
      title: json['title'] as String?,
      readyInMinutes: (json['readyInMinutes'] as num?)?.toInt(),
      servings: (json['servings'] as num?)?.toInt(),
      sourceUrl: json['sourceUrl'] as String?,
      vegetarian: json['vegetarian'] as bool?,
      vegan: json['vegan'] as bool?,
      glutenFree: json['glutenFree'] as bool?,
      dairyFree: json['dairyFree'] as bool?,
      veryHealthy: json['veryHealthy'] as bool?,
      cheap: json['cheap'] as bool?,
      veryPopular: json['veryPopular'] as bool?,
      sustainable: json['sustainable'] as bool?,
      lowFodmap: json['lowFodmap'] as bool?,
      weightWatcherSmartPoints:
          (json['weightWatcherSmartPoints'] as num?)?.toInt(),
      gaps: json['gaps'] as String?,
      preparationMinutes: (json['preparationMinutes'] as num?)?.toInt(),
      cookingMinutes: (json['cookingMinutes'] as num?)?.toInt(),
      aggregateLikes: (json['aggregateLikes'] as num?)?.toInt(),
      healthScore: (json['healthScore'] as num?)?.toInt(),
      creditsText: json['creditsText'] as String?,
      license: json['license'] as String?,
      sourceName: json['sourceName'] as String?,
      pricePerServing: (json['pricePerServing'] as num?)?.toDouble(),
      extendedIngredients: (json['extendedIngredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: json['summary'] as String?,
      dishTypes: (json['dishTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      diets:
          (json['diets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      instructions: json['instructions'] as String?,
      analyzedInstructions: (json['analyzedInstructions'] as List<dynamic>?)
          ?.map((e) => AnalyzedInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      originalId: (json['originalId'] as num?)?.toInt(),
      spoonacularScore: (json['spoonacularScore'] as num?)?.toDouble(),
      spoonacularSourceUrl: json['spoonacularSourceUrl'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'imageType': instance.imageType,
      'title': instance.title,
      'readyInMinutes': instance.readyInMinutes,
      'servings': instance.servings,
      'sourceUrl': instance.sourceUrl,
      'vegetarian': instance.vegetarian,
      'vegan': instance.vegan,
      'glutenFree': instance.glutenFree,
      'dairyFree': instance.dairyFree,
      'veryHealthy': instance.veryHealthy,
      'cheap': instance.cheap,
      'veryPopular': instance.veryPopular,
      'sustainable': instance.sustainable,
      'lowFodmap': instance.lowFodmap,
      'weightWatcherSmartPoints': instance.weightWatcherSmartPoints,
      'gaps': instance.gaps,
      'preparationMinutes': instance.preparationMinutes,
      'cookingMinutes': instance.cookingMinutes,
      'aggregateLikes': instance.aggregateLikes,
      'healthScore': instance.healthScore,
      'creditsText': instance.creditsText,
      'license': instance.license,
      'sourceName': instance.sourceName,
      'pricePerServing': instance.pricePerServing,
      'extendedIngredients': instance.extendedIngredients,
      'summary': instance.summary,
      'dishTypes': instance.dishTypes,
      'diets': instance.diets,
      'instructions': instance.instructions,
      'analyzedInstructions': instance.analyzedInstructions,
      'originalId': instance.originalId,
      'spoonacularScore': instance.spoonacularScore,
      'spoonacularSourceUrl': instance.spoonacularSourceUrl,
    };
