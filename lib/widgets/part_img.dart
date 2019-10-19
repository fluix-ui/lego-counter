import 'package:fluix/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:lego_count/models/set.dart';

class PartImage extends StatelessWidget {
  final Part part;

  PartImage(this.part);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        right: 8,
        left: 8,
      ),
      child: Stack(
        children: <Widget>[
          Image.network(
            part.img,
          ),
          if(part.length != null) Positioned(
            right: 4,
            top: 4,
            child: Container(
              alignment: Alignment.center,
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                )
              ),
              child: Text(
                part.length.toString().replaceFirst(".0", ""),
                style: TextStyle(color: Color(0xff74b4ea),fontWeight: FontWeight.bold,fontSize: 11),
              ),
            ),
          )
        ],
      ),
    );
  }
}
