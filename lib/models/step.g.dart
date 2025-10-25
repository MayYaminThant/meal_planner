// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StepAdapter extends TypeAdapter<Step> {
  @override
  final int typeId = 3;

  @override
  Step read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Step(
      number: fields[1] as int?,
      stepArg: fields[2] as String?,
      ingredients: (fields[3] as List?)?.cast<Ent>(),
      equipment: (fields[4] as List?)?.cast<Ent>(),
      length: fields[5] as Length?,
    );
  }

  @override
  void write(BinaryWriter writer, Step obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.stepArg)
      ..writeByte(3)
      ..write(obj.ingredients)
      ..writeByte(4)
      ..write(obj.equipment)
      ..writeByte(5)
      ..write(obj.length);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      number: (json['number'] as num?)?.toInt(),
      stepArg: json['step'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ent.fromJson(e as Map<String, dynamic>))
          .toList(),
      equipment: (json['equipment'] as List<dynamic>?)
          ?.map((e) => Ent.fromJson(e as Map<String, dynamic>))
          .toList(),
      length: json['length'] == null
          ? null
          : Length.fromJson(json['length'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'number': instance.number,
      'step': instance.stepArg,
      'ingredients': instance.ingredients,
      'equipment': instance.equipment,
      'length': instance.length,
    };
