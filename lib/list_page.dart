import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterlistdemo/province_item.dart';
import 'package:flutterlistdemo/province_notifier.dart';
import 'package:provider/provider.dart';

import 'area_item.dart';
import 'city_item.dart';
import 'entity.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ProvinceEntity> _provinces = [];
  List<ListItem> _items = [];
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _rebuildList() {
    for(int i=0; i<_provinces.length; i++) {
      _items.add(ListItem(_provinces[i]));
      if(_provinces[i].city != null) {
        for(int j=0; j<_provinces[i].city.length; j++) {
          _items.add(ListItem(
            _provinces[i].city[j],
            province: _provinces[i],
          ));
          if(_provinces[i].city[j].area != null) {
            for(int k=0; k<_provinces[i].city[j].area.length; k++) {
              _items.add(ListItem(
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

    Provider.of<ProvinceNotifier>(context, listen: false).addListener((){
      setState(() {

      });
    });
    _controller.addListener(() {
      ScrollPosition scrollPosition = _controller.position;
      print('scrollPosition.axis.index = ${scrollPosition.axis.index}');
    });
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
            controller: _controller,
            cacheExtent: 0.0,
            itemBuilder: (context, index) {
              if(_items[index].item is ProvinceEntity) {
                return ProvinceItem(index, _items[index].item as ProvinceEntity);
              } else if(_items[index].item is CityEntity) {
                if(_items[index].province.hidden)
                  return SizedBox(height: 0,);
                else
                  return CityItem(index, _items[index].item as CityEntity);
              } else {
                if(_items[index].province.hidden || _items[index].city.hidden)
                  return SizedBox(height: 0,);
                else
                  return AreaItem(index, _items[index].item as AreaEntity);
              }
            },
            itemCount: _items.length,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class ListItem {
  final dynamic item;
  final CityEntity city;
  final ProvinceEntity province;
  ListItem(this.item, {this.city, this.province,});
}