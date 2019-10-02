import 'package:flutter/widgets.dart';

class CustomGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final EdgeInsets padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  CustomGrid(
      {@required this.children,
      this.crossAxisCount = 1,
      this.padding = const EdgeInsets.all(0),
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0});

  @override
  Widget build(BuildContext context) {
    var columns = crossAxisCount;
    var rows = (children.length / columns).ceil();

    List<Widget> _getRow(int i) {
      return List.generate(2*columns -1, (j) {
        if(j.isOdd) return SizedBox(width: crossAxisSpacing,);
        if (children.length <= i * columns + j ~/ 2) return Spacer(flex:1,);
        return Expanded(child:children[i * columns + j ~/ 2]);
      });
    }

    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(rows, (i) {
          return Padding(
            padding: EdgeInsets.only(bottom: mainAxisSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: _getRow(i),
            ),
          );
        }),
      ),
    );
  }
}
