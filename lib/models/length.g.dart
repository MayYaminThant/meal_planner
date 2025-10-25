// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'length.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LengthAdapter extends TypeAdapter<Length> {
  @override
  final int typeId = 5;

  @override
  Length read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Length(
      number: fields[1] as int?,
      unit: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Length obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LengthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Length _$LengthFromJson(Map<String, dynamic> json) => Length(
      number: (json['number'] as num?)?.toInt(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$LengthToJson(Length instance) => <String, dynamic>{
      'number': instance.number,
      'unit': instance.unit,
    };
