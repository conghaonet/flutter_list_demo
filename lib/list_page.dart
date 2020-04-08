import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterlistdemo/app_const.dart';
import 'package:flutterlistdemo/list_item_view.dart';
import 'package:flutterlistdemo/province_item.dart';
import 'package:flutterlistdemo/province_notifier.dart';
import 'package:provider/provider.dart';

import 'entity.dart';
import 'list_item_entity.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ProvinceEntity> _provinces = [];
  List<ListItemEntity> _items = [];
  int _topProvinceIndex = 0;
  int _topCityIndex = 1;
  ProvinceEntity _topProvinceEntity;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _rebuildList() {
    for (int i = 0; i < _provinces.length; i++) {
      _items.add(ListItemEntity(_provinces[i]));
      if (_provinces[i].city != null) {
        for (int j = 0; j < _provinces[i].city.length; j++) {
          _items.add(ListItemEntity(
            _provinces[i].city[j],
            province: _provinces[i],
          ));
          if (_provinces[i].city[j].area != null) {
            for (int k = 0; k < _provinces[i].city[j].area.length; k++) {
              _items.add(ListItemEntity(
                _provinces[i].city[j].area[k],
                city: _provinces[i].city[j],
                province: _provinces[i],
              ));
            }
          }
        }
      }
    }
  }

  void _initData() async {
    print('start>>>> ' + DateTime.now().toString());
    String strJson = await DefaultAssetBundle.of(context).loadString('assets/city_code.json');
//    List<ProvinceEntity> provinces = await compute(parseJson, strJson);
    List<dynamic> listDynamic = jsonDecode(strJson);
    _provinces = listDynamic.map((js) => ProvinceEntity.fromJson(js)).toList();
    _rebuildList();
    print('end<<<< ' + DateTime.now().toString());

    Provider.of<ProvinceNotifier>(context, listen: false).addListener(() {
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIST PAGE'),
      ),
      body: Stack(
        children: <Widget>[
          NotificationListener(
            onNotification: (ScrollNotification notification) {
//              print('notification.metrics.pixels.toInt() = ${notification.metrics.pixels.toInt()}'); // 滚动位置。
              double totalHeight = 0;
              for (int i = 0; i < _items.length; i++) {
                if(_items[i].province != null && _items[i].province.hidden) {
                  continue;
                }
                if(_items[i].city != null && _items[i].city.hidden) {
                  continue;
                }
                double height = 0;
                if(_items[i].item is ProvinceEntity) height = AppConst.provinceHeight;
                else if(_items[i].item is CityEntity) height = AppConst.cityHeight;
                else if(_items[i].item is AreaEntity) height = AppConst.areaHeight;

                if (totalHeight <= notification.metrics.pixels && (totalHeight + height) > notification.metrics.pixels) {
                  if (_items[i].item is ProvinceEntity) {
                    _topProvinceEntity = _items[i].item;
                  } else {
                    _topProvinceEntity = _items[i].province;
                  }
                  setState(() {});
                  break;
                } else {
                  totalHeight += height;
                }
              }
              return false;
            },
            child: ListView.builder(
              controller: _controller,
              physics: ClampingScrollPhysics(),
              itemCount: _items.length,
              cacheExtent: 0.0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: _items[index].city != null && _items[index].province != null ? null : () {
                    _items[index].item.hidden = ! _items[index].item.hidden;
                    setState(() {});
                  },
                  child: ListItemView(
                    index: index,
                    itemEntity: _items[index],
                  ),
                );
              },
            ),
          ),
          if (_items.length > 0 && _topProvinceEntity != null)
            InkWell(
              onTap: () {
                double offsetHeight = 0;
                for (int i = 0; i < _items.length; i++) {
                  if (_items[i].item == _topProvinceEntity) {
                    _controller.jumpTo(offsetHeight);
                  } else {
                    if(_items[i].province != null && _items[i].province.hidden) {
                      continue;
                    }
                    if(_items[i].city != null && _items[i].city.hidden) {
                      continue;
                    }
                    double height = 0;
                    if(_items[i].item is ProvinceEntity) height = AppConst.provinceHeight;
                    else if(_items[i].item is CityEntity) height = AppConst.cityHeight;
                    else if(_items[i].item is AreaEntity) height = AppConst.areaHeight;
                    offsetHeight += height;
                  }
                }
                Future.delayed(Duration(milliseconds: 100), (){
                  _topProvinceEntity.hidden = !_topProvinceEntity.hidden;
                  setState(() {});
                });
              },
              child: ProvinceItem(99999, _topProvinceEntity),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
