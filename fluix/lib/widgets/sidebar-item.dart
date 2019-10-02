import 'dart:async';

import 'package:fluix/theme/colors.dart';
import 'package:fluix/theme/sidebar.dart';
import 'package:fluix/theme/theme.dart';
import 'package:flutter/material.dart';

class SidebarItem extends StatefulWidget {
  Widget icon;
  String title;
  String iconDescription;
  bool selected;
  GestureTapCallback onTap;

  bool expanded = false;
  bool showIconDescription;

  SidebarTheme theme;

  SidebarItem(
      {@required this.icon,
      this.onTap,
      this.theme,
      this.showIconDescription = true,
      this.iconDescription,
      this.title,
      this.selected = false,
      this.expanded = true,});

  @override
  _SidebarItemState createState() => _SidebarItemState();

  SidebarItem copyWith(
      {Widget icon,
      String title,
      bool showIconDescription,
      SidebarTheme theme,
      bool expanded,
      bool selected}) {
    print("build");
    return SidebarItem(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      expanded: expanded ?? this.expanded,
      selected: selected ?? this.selected,
      onTap: this.onTap,
      theme: theme ?? this.theme,
      showIconDescription: showIconDescription ?? this.showIconDescription,
      iconDescription: this.iconDescription,
    );
  }
}

class _SidebarItemState extends State<SidebarItem> {
  bool focused = false;

  void onTap() {
    if (widget.onTap != null) {
      widget.onTap();
      setState(() {
        focused = true;
      });
      Timer(Duration(milliseconds: 200), () {
        setState(() {
          focused = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = FluidTheme.of(context);
    var sidetheme = widget.theme ?? theme.sidebar;

    Color getColor() {
      if (focused) return sidetheme.hover ?? theme.primary.darker;
      return widget.selected != null && widget.selected
          ? (sidetheme.selected ?? theme.primary)
          : (sidetheme.foreground ?? theme.typography.baseColor);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        color: widget.selected != null && widget.selected
            ? sidetheme.selectedBackground
            : Liquids.transparent,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 80,
              child: IconTheme(
                data: IconThemeData(color: getColor(), size: sidetheme.iconSize ?? 24),
                child: widget.showIconDescription
                    ? AnimatedCrossFade(
                        duration: const Duration(milliseconds: 100),
                        firstChild: widget.icon,
                        secondChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            widget.icon,
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.iconDescription ?? widget.title,
                              style: TextStyle(fontSize: 14, color: getColor()),
                            ),
                          ],
                        ),
                        crossFadeState: widget.expanded
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      )
                    : widget.icon,
              ),
            ),
            Flexible(
              child: Text(
                widget.title,
                style: TextStyle(color: getColor()),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return widget.expanded.toString();
  }
}
