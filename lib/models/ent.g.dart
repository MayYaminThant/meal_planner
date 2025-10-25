// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntAdapter extends TypeAdapter<Ent> {
  @override
  final int typeId = 4;

  @override
  Ent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ent(
      id: fields[1] as int?,
      name: fields[2] as String?,
      localizedName: fields[3] as String?,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Ent obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.localizedName)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ent _$EntFromJson(Map<String, dynamic> json) => Ent(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      localizedName: json['localizedName'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$EntToJson(Ent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'localizedName': instance.localizedName,
      'image': instance.image,
    };
