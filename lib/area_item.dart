import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/entity.dart';

class AreaItem extends StatelessWidget{
  final int index;
  final AreaEntity entity;

  AreaItem(this.index, this.entity);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$index  ${entity.code}  ${entity.name}', style: TextStyle(fontSize: 14,),),
    );
  }

}