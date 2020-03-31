import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/entity.dart';

class CityItem extends StatelessWidget{
  final int index;
  final CityEntity entity;

  CityItem(this.index, this.entity);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.5),
      child: Text('$index  ${entity.code}  ${entity.name}', style: TextStyle(fontSize: 16,),),
    );
  }

}