import 'package:flutterlistdemo/base_entity.dart';

class ListItemEntity {
  final BaseEntity item;
  final int cityIndex;
  final int provinceIndex;

  ListItemEntity(this.item, {this.provinceIndex, this.cityIndex});
}
