// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measures.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasuresAdapter extends TypeAdapter<Measures> {
  @override
  final int typeId = 7;

  @override
  Measures read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Measures(
      us: fields[1] as Metric?,
      metric: fields[2] as Metric?,
    );
  }

  @override
  void write(BinaryWriter writer, Measures obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.us)
      ..writeByte(2)
      ..write(obj.metric);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasuresAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measures _$MeasuresFromJson(Map<String, dynamic> json) => Measures(
      us: json['us'] == null
          ? null
          : Metric.fromJson(json['us'] as Map<String, dynamic>),
      metric: json['metric'] == null
          ? null
          : Metric.fromJson(json['metric'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeasuresToJson(Measures instance) => <String, dynamic>{
      'us': instance.us,
      'metric': instance.metric,
    };
