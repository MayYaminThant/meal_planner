import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ent.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Ent extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "id")
  int? id;
  @HiveField(2)
  @JsonKey(name: "name")
  String? name;
  @HiveField(3)
  @JsonKey(name: "localizedName")
  String? localizedName;
  @HiveField(4)
  @JsonKey(name: "image")
  String? image;

  Ent({
    this.id,
    this.name,
    this.localizedName,
    this.image,
  });

  factory Ent.fromJson(Map<String, dynamic> json) => _$EntFromJson(json);

  Map<String, dynamic> toJson() => _$EntToJson(this);
}
