import 'package:flutterlistdemo/base_entity.dart';

import 'entity.dart';

class ListItemEntity {
  final BaseEntity item;
  final CityEntity city;
  final ProvinceEntity province;
  @Deprecated('see AppConst')
  double height = 0;

  ListItemEntity(
    this.item, {
    this.city,
    this.province,
  });
}
