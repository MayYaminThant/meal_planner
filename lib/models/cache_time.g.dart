// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheTimeAdapter extends TypeAdapter<CacheTime> {
  @override
  final int typeId = 10;

  @override
  CacheTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheTime(
      lastUpdated: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CacheTime obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
