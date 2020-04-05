import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/entity.dart';

class ProvinceItem extends StatelessWidget{
  final int index;
  final ProvinceEntity province;

  ProvinceItem(this.index, this.province, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey,
      child: Text('$index  ${province.code}  ${province.name}', style: TextStyle(fontSize: 18,),),
    );
  }
}
