import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutterlistdemo/list_item_entity.dart';

import 'entity.dart';

class ListData {
  List<ProvinceEntity> _provinces = [];
  List<ProvinceEntity> get provinces => _provinces;
  List<ListItemEntity> _items = [];
  List<ListItemEntity> get items => _items;

  static final ListData _listData = ListData._();
  factory ListData() {
    return _listData;
  }
  ListData._() {
    //初始化代码
  }

  Future<List<ListItemEntity>> refreshData() async {
    _provinces.clear();
    _items.clear();
    String strJson = await rootBundle.loadString('assets/city_code.json');
    List<dynamic> listDynamic = jsonDecode(strJson);
    _provinces = listDynamic.map((js) => ProvinceEntity.fromJson(js)).toList();
    _rebuildList();
    return _items;
  }

  void _rebuildList() {
    for (int i = 0; i < _provinces.length; i++) {
      final int provinceIndex = _items.length;
      _items.add(ListItemEntity(_provinces[i]));
      if (_provinces[i].city != null) {
        for (int j = 0; j < _provinces[i].city.length; j++) {
          final int cityIndex = _items.length;
          _items.add(ListItemEntity(
            _provinces[i].city[j],
            provinceIndex: provinceIndex,
          ));
          if (_provinces[i].city[j].area != null) {
            for (int k = 0; k < _provinces[i].city[j].area.length; k++) {
              _items.add(ListItemEntity(
                _provinces[i].city[j].area[k],
                cityIndex: cityIndex,
                provinceIndex: provinceIndex,
              ));
            }
          }
        }
      }
    }
  }
}
ListData listData = ListData();