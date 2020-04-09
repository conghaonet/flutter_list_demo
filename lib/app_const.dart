import 'package:flutterlistdemo/entity.dart';

import 'list_item_entity.dart';

class AppConst {
  static double provinceHeight = 0;
  static double cityHeight = 0;
  static double areaHeight = 0;
  static getItemHeight(ListItemEntity entity) {
    if(entity.item is ProvinceEntity) return provinceHeight;
    else if(entity.item is CityEntity) return cityHeight;
    else if(entity.item is AreaEntity) return areaHeight;
    else return 0;
  }
}