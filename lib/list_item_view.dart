import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/app_const.dart';
import 'package:flutterlistdemo/list_item_entity.dart';
import 'package:flutterlistdemo/province_item.dart';
import 'package:flutterlistdemo/province_notifier.dart';
import 'package:provider/provider.dart';

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
    return InkWell(
      key: _key,
      onTap: widget.itemEntity.item is AreaEntity
          ? null
          : () {
              if (widget.itemEntity.item is ProvinceEntity) {
                (widget.itemEntity.item as ProvinceEntity).hidden = !(widget.itemEntity.item as ProvinceEntity).hidden;
              } else if (widget.itemEntity.item is CityEntity) {
                (widget.itemEntity.item as CityEntity).hidden = !(widget.itemEntity.item as CityEntity).hidden;
              }
              Provider.of<ProvinceNotifier>(context, listen: false).refreshProvince();
            },
      child: _buildItemWidget(),
    );
  }

  Widget _buildItemWidget() {
    if (widget.itemEntity.item is ProvinceEntity) {
      return ProvinceItem(widget.index, widget.itemEntity.item as ProvinceEntity);
    } else if (widget.itemEntity.item is CityEntity) {
      if (!widget.itemEntity.province.hidden) return CityItem(widget.index, widget.itemEntity.item as CityEntity);
    } else {
      if (!widget.itemEntity.province.hidden && !widget.itemEntity.city.hidden) return AreaItem(widget.index, widget.itemEntity.item as AreaEntity);
    }
    return SizedBox(
      height: 0,
    );
  }
}
