import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterlistdemo/province_title.dart';

import 'entity.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ProvinceEntity> provinces = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    print('start>>>> ' + DateTime.now().toString());
    String strJson = await DefaultAssetBundle.of(context).loadString('assets/city_code.json');
//    List<ProvinceEntity> provinces = await compute(parseJson, strJson);
    List<dynamic> listDynamic = jsonDecode(strJson);
    provinces = listDynamic.map((js) => ProvinceEntity.fromJson(js)).toList();
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
              return ProvinceTitle(index, provinces[index]);
            },
            itemCount: provinces.length,
          ),
        ),
      ),
    );
  }
}
