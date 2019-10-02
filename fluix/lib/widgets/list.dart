import 'package:flutter/material.dart';
import 'package:fluix/widgets/divider.dart';

typedef ListBuilder = Widget Function(int);

class FluidList extends StatelessWidget {

  final Color backgroundColor;
  final List<Widget> children;
  final double cornerRadius = 6;

  FluidList({this.backgroundColor,@required this.children}); 
  factory FluidList.builder({Color backgroundColor,@required int itemCount,@required ListBuilder builder}) {
    List<Widget> children = [];
    for (var i = 0; i < itemCount; i++) {
      children.add(builder(i));
    }
    return FluidList(children: children,backgroundColor: backgroundColor,);
  }
  
  @override
  Widget build(BuildContext context) {

    List tempChild = children;

    if(children != null && children.length > 1){
      for (int i = children.length -1; i > 0; i--) {
        tempChild.insert(i, FluidDivider());
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: this.backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}