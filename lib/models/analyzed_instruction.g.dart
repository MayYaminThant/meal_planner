// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyzed_instruction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnalyzedInstructionAdapter extends TypeAdapter<AnalyzedInstruction> {
  @override
  final int typeId = 2;

  @override
  AnalyzedInstruction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnalyzedInstruction(
      name: fields[1] as String?,
      steps: (fields[2] as List?)?.cast<Step>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnalyzedInstruction obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.steps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalyzedInstructionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyzedInstruction _$AnalyzedInstructionFromJson(Map<String, dynamic> json) =>
    AnalyzedInstruction(
      name: json['name'] as String?,
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyzedInstructionToJson(
        AnalyzedInstruction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'steps': instance.steps,
    };
