import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/entity.dart';

class ProvinceItem extends StatelessWidget{
  final int index;
  final ProvinceEntity entity;

  ProvinceItem(this.index, this.entity);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        color: Colors.grey,
        child: Text('$index  ${entity.code}  ${entity.name}', style: TextStyle(fontSize: 18,),),
      ),
    );
  }

}