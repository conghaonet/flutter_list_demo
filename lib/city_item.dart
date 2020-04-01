import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/entity.dart';
import 'package:flutterlistdemo/province_notifier.dart';
import 'package:provider/provider.dart';

class CityItem extends StatefulWidget{
  final int index;
  final CityEntity city;

  CityItem(this.index, this.city,);

  @override
  _CityItemState createState() => _CityItemState();
}

class _CityItemState extends State<CityItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.city.hidden = !widget.city.hidden;
        Provider.of<ProvinceNotifier>(context, listen: false).refreshProvince();
      },
      child: Container(
        color: Colors.grey.withOpacity(0.5),
        child: Text('${widget.index}  ${widget.city.code}  ${widget.city.name}', style: TextStyle(fontSize: 16,),),
      ),
    );
  }
}