import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/entity.dart';
import 'package:flutterlistdemo/province_notifier.dart';
import 'package:provider/provider.dart';

class ProvinceItem extends StatefulWidget{
  final int index;
  final ProvinceEntity province;

  ProvinceItem(this.index, this.province);

  @override
  _ProvinceItemState createState() => _ProvinceItemState();
}

class _ProvinceItemState extends State<ProvinceItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.province.hidden = !widget.province.hidden;
        Provider.of<ProvinceNotifier>(context, listen: false).refreshProvince();
      },
      child: Container(
        color: Colors.grey,
        child: Text('${widget.index}  ${widget.province.code}  ${widget.province.name}', style: TextStyle(fontSize: 18,),),
      ),
    );
  }
}