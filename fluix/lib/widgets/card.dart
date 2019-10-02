import 'package:flutter/widgets.dart';
import 'package:fluix/theme/theme.dart';

class FluidCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final int elevation;
  final EdgeInsets padding;
  final Alignment alignChild;

  FluidCard(
      {this.child,
      this.backgroundColor,
      this.borderRadius = 6.0,
      this.elevation = 0,
      this.padding,
      this.alignChild = Alignment.topLeft});

  @override
  Widget build(BuildContext context) {
    var theme = FluidTheme.of(context);

    List<BoxShadow> shadows = [];
    if (elevation != null) {
      if (elevation > 0)
        shadows.add(BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 2),
            color: Color.fromARGB(12, 0, 0, 0)));
      if (elevation == 2)
        shadows.add(BoxShadow(
            blurRadius: 20,
            offset: Offset(0, 10),
            color: Color.fromARGB(25, 0, 0, 0)));
      if (elevation >= 3)
        shadows.add(BoxShadow(
            blurRadius: 40,
            offset: Offset(0, 30),
            color: Color.fromARGB(51, 0, 0, 0)));
    }
    return LayoutBuilder(
      builder: (context, size) => Container(
            alignment: alignChild,
            padding: padding ??
                EdgeInsets.symmetric(
                    horizontal:
                        size.hasBoundedWidth ? size.maxWidth * 0.08 : 16,
                    vertical:
                        size.hasBoundedHeight ? size.minHeight * 0.08 : 16),
            child: child,
            decoration: BoxDecoration(
                color: backgroundColor ?? theme.cardColor,
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
                boxShadow: shadows),
          ),
    );
  }
}
