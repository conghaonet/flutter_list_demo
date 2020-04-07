import 'entity.dart';

class ListItemEntity {
  final dynamic item;
  final CityEntity city;
  final ProvinceEntity province;
  double height = 0;

  ListItemEntity(
    this.item, {
    this.city,
    this.province,
  });
}
