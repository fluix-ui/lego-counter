import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluix/theme/theme.dart';

class FluidShell extends StatefulWidget {
  final Color backgroundColor;
  final Widget body;
  final Widget sideBar;
  final PreferredSizeWidget appBar;
  final bool primary;

  FluidShell({
    this.backgroundColor,
    this.body,
    this.sideBar,
    this.appBar,
    this.primary = true,
  });

  @override
  _FluidShellState createState() => _FluidShellState();
}

class _FluidShellState extends State<FluidShell> {
  @override
  Widget build(BuildContext context) {
    var theme = FluidTheme.of(context);
    var mediaQuery = MediaQuery.of(context);

    Widget body = Expanded(
      child: Material(
        color: widget.backgroundColor ?? theme.background,
        child: widget.body,
      ),
    );

    if (widget.appBar != null) {
      final double topPadding = widget.primary ? mediaQuery.padding.top : 0.0;
      final double extent = widget.appBar.preferredSize.height + topPadding;
      assert(extent >= 0.0 && extent.isFinite);

      return Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: extent),
            child: widget.appBar,
          ),
          if (widget.sideBar == null)
            MediaQuery.removePadding(context: context, child: body),
          if (widget.sideBar != null)
            MediaQuery.removePadding(
              context: context,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: mediaQuery.size.height - extent,
                    maxWidth: mediaQuery.size.width),
                child: Row(
                  children: <Widget>[
                    widget.sideBar,
                    body,
                  ],
                ),
              ),
            )
        ],
      );
    }

    return body;
  }
}
