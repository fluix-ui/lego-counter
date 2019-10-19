import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomImage extends StatelessWidget {
  final String img;
  final double height;
  final double width;

  CustomImage(this.img, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      image: img,
      placeholder: kTransparentImage,
      width: width,
      height: height,
    );
  }
}
