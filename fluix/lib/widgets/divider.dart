import 'package:flutter/material.dart';
import 'package:fluix/theme/theme.dart';

class FluidDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = FluidTheme.of(context);
    return Container(
      height: 1,
      color: theme.disabledColor,
    );
  }
}