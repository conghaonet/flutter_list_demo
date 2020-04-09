import 'package:flutter/material.dart';
import 'package:flutterlistdemo/app_const.dart';
import 'package:flutterlistdemo/list_data.dart';
import 'package:flutterlistdemo/list_item_view.dart';
import 'package:flutterlistdemo/province_item.dart';
import 'package:flutterlistdemo/province_notifier.dart';
import 'package:provider/provider.dart';

import 'entity.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _topProvinceIndex = 0;
  int _topCityIndex = 1;
  int _topItemIndex = 0;
  ProvinceEntity _topProvinceEntity;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _initData();
  }


  void _initData() async {
    print('start>>>> ' + DateTime.now().toString());
    await listData.refreshData();
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
              for (int i = 0; i < listData.items.length; i++) {
                if(listData.items[i].province != null && listData.items[i].province.hidden) {
                  continue;
                }
                if(listData.items[i].city != null && listData.items[i].city.hidden) {
                  continue;
                }
                double height = 0;
                if(listData.items[i].item is ProvinceEntity) height = AppConst.provinceHeight;
                else if(listData.items[i].item is CityEntity) height = AppConst.cityHeight;
                else if(listData.items[i].item is AreaEntity) height = AppConst.areaHeight;

                if (totalHeight <= notification.metrics.pixels && (totalHeight + height) > notification.metrics.pixels) {
                  _topItemIndex=i;
                  if (listData.items[i].item is ProvinceEntity) {
                    _topProvinceIndex = i;
                    _topProvinceEntity = listData.items[i].item;
                  } else {
                    _topProvinceEntity = listData.items[i].province;
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
              itemCount: listData.items.length,
              cacheExtent: 0.0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: listData.items[index].city != null && listData.items[index].province != null ? null : () {
                    listData.items[index].item.hidden = ! listData.items[index].item.hidden;
                    setState(() {});
                  },
                  child: ListItemView(
                    index: index,
                    itemEntity: listData.items[index],
                  ),
                );
              },
            ),
          ),
          if (listData.items.length > 0 && _topProvinceEntity != null)
            InkWell(
              onTap: () {
                double offsetHeight = 0;
                for (int i = 0; i < listData.items.length; i++) {
                  if (listData.items[i].item == _topProvinceEntity) {
                    _controller.jumpTo(offsetHeight);
                  } else {
                    if(listData.items[i].province != null && listData.items[i].province.hidden) {
                      continue;
                    }
                    if(listData.items[i].city != null && listData.items[i].city.hidden) {
                      continue;
                    }
                    double height = 0;
                    if(listData.items[i].item is ProvinceEntity) height = AppConst.provinceHeight;
                    else if(listData.items[i].item is CityEntity) height = AppConst.cityHeight;
                    else if(listData.items[i].item is AreaEntity) height = AppConst.areaHeight;
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
