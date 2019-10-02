import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluix/fluix.dart';

class GridCard extends StatefulWidget {

  final GestureTapCallback onTap;
  final GestureDoubleTapCallback onDoubleTap;
  final Widget child;
  final Color color;
  final Color activeColor;

  GridCard({this.child,this.onTap,this.onDoubleTap,this.activeColor,this.color});


  @override
  _GridCardState createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {

  int elevation = 0;
  Color color;

  startTimer(){
    color = widget.activeColor ?? Liquids.sensitiveGrey.lightest;
    setState(() => elevation = 1);
    
    Timer(Duration(milliseconds: 200),(){
      color = widget.color;
      setState(() => elevation = 0);
    });
  }

  onDouble(){
    startTimer();
    if(widget.onDoubleTap != null) widget.onDoubleTap();
  }
  onTap(){
    startTimer();
    if(widget.onTap != null) widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => elevation = 2),
      onTapUp: (_) => setState(() => elevation = 0),
      onTap: onTap,
      onDoubleTap: onDouble,
      child: FluidCard(
        padding: EdgeInsets.all(0),
        elevation: elevation,
        backgroundColor: color ?? widget.color,
        child: widget.child,
      ),
    );
  }
}