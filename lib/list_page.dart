import 'package:flutter/material.dart';
import 'package:flutterlistdemo/app_const.dart';
import 'package:flutterlistdemo/list_data.dart';
import 'package:flutterlistdemo/list_item_view.dart';
import 'entity.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _topProvinceIndex = 0;
  int _topCityIndex = 1;
  int _topItemIndex = 0;
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
    setState(() {});
    _controller.addListener((){
      print('_controller.offset = ${_controller.offset}');
      double totalHeight = 0;
      for (int i = 0; i < listData.items.length; i++) {
        if(listData.items[i].provinceIndex != null && listData.items[listData.items[i].provinceIndex].item.hidden) {
          continue;
        }
        if(listData.items[i].cityIndex != null && listData.items[listData.items[i].cityIndex].item.hidden) {
          continue;
        }
        double height = AppConst.getItemHeight(listData.items[i]);
        if (totalHeight <= _controller.offset && (totalHeight + height) > _controller.offset) {
          _topItemIndex = i;
          _topProvinceIndex = listData.items[i].provinceIndex ?? i;
          setState(() {});
          break;
        } else {
          totalHeight += height;
        }
      }
    });
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
/*
            onNotification: (ScrollNotification notification) {
              print('notification.metrics.pixels.toInt() = ${notification.metrics.pixels.toInt()}'); // 滚动位置。
              double totalHeight = 0;
              for (int i = 0; i < listData.items.length; i++) {
                if(listData.items[i].provinceIndex != null && listData.items[listData.items[i].provinceIndex].item.hidden) {
                  continue;
                }
                if(listData.items[i].cityIndex != null && listData.items[listData.items[i].cityIndex].item.hidden) {
                  continue;
                }
                double height = AppConst.getItemHeight(listData.items[i]);
                if (totalHeight <= notification.metrics.pixels && (totalHeight + height) > notification.metrics.pixels) {
                  _topItemIndex = i;
                  _topProvinceIndex = listData.items[i].provinceIndex ?? i;
                  Future((){
                    setState(() {

                    });
                  });
                  setState(() {});
                  break;
                } else {
                  totalHeight += height;
                }
              }
              return false;
            },
*/
            child: ListView.builder(
              controller: _controller,
              physics: ClampingScrollPhysics(),
              itemCount: listData.items.length,
              cacheExtent: 0.0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: listData.items[index].cityIndex != null && listData.items[index].provinceIndex != null ? null : () {
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
          if (listData.items.length > 0)
            InkWell(
              onTap: () {
                double offsetHeight = 0;
                for (int i = 0; i < listData.items.length; i++) {
                  if (i == _topProvinceIndex) {
                    _controller.jumpTo(offsetHeight);
                  } else {
                    if(listData.items[i].provinceIndex != null && listData.items[listData.items[i].provinceIndex].item.hidden) {
                      continue;
                    }
                    if(listData.items[i].cityIndex != null && listData.items[listData.items[i].cityIndex].item.hidden) {
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
                  listData.items[_topProvinceIndex].item.hidden = !listData.items[_topProvinceIndex].item.hidden;
                  setState(() {});
                });
              },
              child: ListItemView(index: _topProvinceIndex, itemEntity: listData.items[_topProvinceIndex]),
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
