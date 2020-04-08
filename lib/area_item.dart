import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlistdemo/entity.dart';

class AreaItem extends StatelessWidget {
  final int index;
  final AreaEntity area;

  AreaItem(this.index, this.area, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: Text(
        '$index  ${area.code}  ${area.name}',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
