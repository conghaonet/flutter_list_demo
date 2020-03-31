import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/entity.dart';

class CityTitle extends StatelessWidget{
  final int index;
  final CityEntity entity;

  CityTitle(this.index, this.entity);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Text('$index  ${entity.code}  ${entity.name}'),
    );
  }

}