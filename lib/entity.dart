import 'package:flutterlistdemo/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@JsonSerializable()
class ProvinceEntity extends BaseEntity {
  String name;
  String code;
  List<CityEntity> city;

  ProvinceEntity(
    this.name,
    this.code,
    this.city,
  );

  factory ProvinceEntity.fromJson(Map<String, dynamic> json) {
    final province = _$ProvinceEntityFromJson(json);
    if (province.hidden == null) province.hidden = false;
    return province;
  }

  Map<String, dynamic> toJson() => _$ProvinceEntityToJson(this);
}

@JsonSerializable()
class CityEntity extends BaseEntity {
  String name;
  String code;
  List<AreaEntity> area;

  CityEntity(this.name, this.code, this.area);

  factory CityEntity.fromJson(Map<String, dynamic> json) {
    final city = _$CityEntityFromJson(json);
    if (city.hidden == null) city.hidden = false;
    return city;
  }

  Map<String, dynamic> toJson() => _$CityEntityToJson(this);
}

@JsonSerializable()
class AreaEntity extends BaseEntity {
  String name;
  String code;

  AreaEntity(this.name, this.code);

  factory AreaEntity.fromJson(Map<String, dynamic> json) => _$AreaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AreaEntityToJson(this);
}
