import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget fallback;
  final Widget mobile;
  final Widget landscape;
  final Widget tablet;
  final Widget desktop;
  final Widget web;

  ResponsiveWidget({
    @required this.fallback,
    this.mobile,
    this.landscape,
    this.tablet,
    this.desktop,
    this.web,
  }) : assert(fallback != null);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var width = media.size.width;
      print(width);

      bool isMobile = width < 768;
      bool isTablet = width < 992 && width >= 768;
      bool isDesktop = width >= 992;
      bool isLandscape = media.orientation == Orientation.landscape;

      if(isMobile && isLandscape && landscape != null) return landscape;
      if(isMobile && mobile != null) return mobile;
      if(isTablet && tablet != null) return tablet;
      if(isTablet && landscape != null) return landscape;
      if(isTablet && mobile != null) return mobile;
      if(isDesktop && desktop != null) return desktop;
      // TODO: Support web
      if(isDesktop && web != null) return web;
      return fallback;
  }
}
