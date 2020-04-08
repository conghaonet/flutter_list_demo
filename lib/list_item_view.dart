import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/app_const.dart';
import 'package:flutterlistdemo/list_item_entity.dart';
import 'package:flutterlistdemo/province_item.dart';

import 'area_item.dart';
import 'city_item.dart';
import 'entity.dart';

class ListItemView extends StatefulWidget {
  final ListItemEntity itemEntity;
  final int index;

  ListItemView({this.itemEntity, this.index});

  @override
  _ListItemViewState createState() => _ListItemViewState();
}

class _ListItemViewState extends State<ListItemView> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if((AppConst.provinceHeight <= 0 && widget.itemEntity.item is ProvinceEntity)) {
        RenderBox _renderBox = _key.currentContext.findRenderObject();
        Size size = _renderBox.size;
        AppConst.provinceHeight = size.height;
      } else if((AppConst.cityHeight <= 0 && widget.itemEntity.item is CityEntity)) {
        RenderBox _renderBox = _key.currentContext.findRenderObject();
        Size size = _renderBox.size;
        AppConst.cityHeight = size.height;
      } else if((AppConst.areaHeight <= 0 && widget.itemEntity.item is AreaEntity)) {
        RenderBox _renderBox = _key.currentContext.findRenderObject();
        Size size = _renderBox.size;
        AppConst.areaHeight = size.height;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemEntity.item is ProvinceEntity) {
      return ProvinceItem(widget.index, widget.itemEntity.item as ProvinceEntity, key: _key,);
    } else if (widget.itemEntity.item is CityEntity) {
      if (!widget.itemEntity.province.hidden) return CityItem(widget.index, widget.itemEntity.item as CityEntity, key: _key,);
    } else {
      if (!widget.itemEntity.province.hidden && !widget.itemEntity.city.hidden) return AreaItem(widget.index, widget.itemEntity.item as AreaEntity, key: _key,);
    }
    return SizedBox(
      height: 0,
    );
  }
}
