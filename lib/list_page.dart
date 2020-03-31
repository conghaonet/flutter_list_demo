import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterlistdemo/province_title.dart';

import 'area_title.dart';
import 'city_title.dart';
import 'entity.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ProvinceEntity> provinces = [];
  List<ListItem> items = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _rebuildList() {
    for(int i=0; i<provinces.length; i++) {
      items.add(ListItem(provinces[i]));
      if(provinces[i].city != null) {
        for(int j=0; j<provinces[i].city.length; j++) {
          items.add(ListItem(provinces[i].city[j]));
          if(provinces[i].city[j].area != null) {
            for(int k=0; k<provinces[i].city[j].area.length; k++) {
              items.add(ListItem(provinces[i].city[j].area[k]));
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
    provinces = listDynamic.map((js) => ProvinceEntity.fromJson(js)).toList();
    _rebuildList();
    print('end<<<< ' + DateTime.now().toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIST PAGE'),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if(items[index].item is ProvinceEntity) {
                return ProvinceTitle(index, items[index].item as ProvinceEntity);
              } else if(items[index].item is CityEntity) {
                return CityTitle(index, items[index].item as CityEntity);
              } else {
                return AreaTitle(index, items[index].item as AreaEntity);
              }
            },
            itemCount: items.length,
          ),
        ),
      ),
    );
  }
}

class ListItem {
  final dynamic item;
  ListItem(this.item);
}