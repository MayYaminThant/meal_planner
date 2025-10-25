// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = 6;

  @override
  Ingredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredient(
      id: fields[1] as int?,
      aisle: fields[2] as String?,
      image: fields[3] as String?,
      consistency: fields[4] as Consistency?,
      name: fields[5] as String?,
      nameClean: fields[6] as String?,
      original: fields[7] as String?,
      originalName: fields[8] as String?,
      amount: fields[9] as double?,
      unit: fields[10] as String?,
      meta: (fields[11] as List?)?.cast<String>(),
      measures: fields[12] as Measures?,
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.aisle)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.consistency)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.nameClean)
      ..writeByte(7)
      ..write(obj.original)
      ..writeByte(8)
      ..write(obj.originalName)
      ..writeByte(9)
      ..write(obj.amount)
      ..writeByte(10)
      ..write(obj.unit)
      ..writeByte(11)
      ..write(obj.meta)
      ..writeByte(12)
      ..write(obj.measures);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: (json['id'] as num?)?.toInt(),
      aisle: json['aisle'] as String?,
      image: json['image'] as String?,
      consistency:
          $enumDecodeNullable(_$ConsistencyEnumMap, json['consistency']),
      name: json['name'] as String?,
      nameClean: json['nameClean'] as String?,
      original: json['original'] as String?,
      originalName: json['originalName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      meta: (json['meta'] as List<dynamic>?)?.map((e) => e as String).toList(),
      measures: json['measures'] == null
          ? null
          : Measures.fromJson(json['measures'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aisle': instance.aisle,
      'image': instance.image,
      'consistency': _$ConsistencyEnumMap[instance.consistency],
      'name': instance.name,
      'nameClean': instance.nameClean,
      'original': instance.original,
      'originalName': instance.originalName,
      'amount': instance.amount,
      'unit': instance.unit,
      'meta': instance.meta,
      'measures': instance.measures,
    };

const _$ConsistencyEnumMap = {
  Consistency.LIQUID: 'LIQUID',
  Consistency.SOLID: 'SOLID',
};
