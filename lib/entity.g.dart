// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceEntity _$ProvinceEntityFromJson(Map<String, dynamic> json) {
  return ProvinceEntity(
    json['name'] as String,
    json['code'] as String,
    (json['city'] as List)
        ?.map((e) =>
            e == null ? null : CityEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..hidden = json['hidden'] as bool;
}

Map<String, dynamic> _$ProvinceEntityToJson(ProvinceEntity instance) =>
    <String, dynamic>{
      'hidden': instance.hidden,
      'name': instance.name,
      'code': instance.code,
      'city': instance.city,
    };

CityEntity _$CityEntityFromJson(Map<String, dynamic> json) {
  return CityEntity(
    json['name'] as String,
    json['code'] as String,
    (json['area'] as List)
        ?.map((e) =>
            e == null ? null : AreaEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..hidden = json['hidden'] as bool;
}

Map<String, dynamic> _$CityEntityToJson(CityEntity instance) =>
    <String, dynamic>{
      'hidden': instance.hidden,
      'name': instance.name,
      'code': instance.code,
      'area': instance.area,
    };

AreaEntity _$AreaEntityFromJson(Map<String, dynamic> json) {
  return AreaEntity(
    json['name'] as String,
    json['code'] as String,
  )..hidden = json['hidden'] as bool;
}

Map<String, dynamic> _$AreaEntityToJson(AreaEntity instance) =>
    <String, dynamic>{
      'hidden': instance.hidden,
      'name': instance.name,
      'code': instance.code,
    };
