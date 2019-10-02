import 'dart:async';

import 'package:fluix/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluix/theme/theme.dart';

import 'checkbox.dart';

class FluidListItem extends StatefulWidget {
  final bool enabled;
  final bool selected;
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final bool highlight;

  FluidListItem({
    this.leading,
    this.enabled,
    this.selected,
    @required this.title,
    this.trailing,
    this.onLongPress,
    this.highlight,
    this.onTap,
  });
  FluidListItem.head({
    this.leading,
    this.enabled,
    this.selected,
    @required this.title,
    this.trailing,
    this.onLongPress,
    this.highlight = true,
    this.onTap,
  });
  factory FluidListItem.icon({
    @required Icon icon,
    bool enabled,
    bool selected,
    @required Widget title,
    Widget trailing,
    GestureLongPressCallback onLongPress,
    bool highlight,
    GestureTapCallback onTap,
  }) =>
      FluidListItem(
        leading: icon,
        title: title,
        selected: selected,
        trailing: trailing,
        enabled: enabled,
        onLongPress: onLongPress,
        onTap: onTap,
      );
  factory FluidListItem.checkbox({
    @required value,
    bool enabled = true,
    bool selected,
    @required Widget title,
    Widget trailing,
    GestureLongPressCallback onLongPress,
    bool highlight,
    ValueChanged<bool> onChanged,
  }) =>
      FluidListItem(
        leading: CheckBox(
          value: value,
          onChanged: onChanged,
          enabled: enabled,
        ),
        title: title,
        selected: selected,
        trailing: trailing,
        highlight: highlight,
        enabled: enabled,
        onLongPress: onLongPress,
        onTap: () => onChanged(!value),
      );
  factory FluidListItem.toggle({
    @required value,
    bool enabled = true,
    bool selected,
    @required Widget title,
    Widget leading,
    GestureLongPressCallback onLongPress,
    bool highlight,
    ValueChanged<bool> onChanged,
  }) =>
      FluidListItem(
        leading: leading,
        title: title,
        selected: selected,
        trailing: FluidToggle(
          value: value,
          onChanged: onChanged,
          enabled: enabled,
        ),
        highlight: highlight,
        enabled: enabled,
        onLongPress: onLongPress,
        onTap: () => onChanged(!value),
      );
  factory FluidListItem.navigate({
    Widget leading,
    bool enabled,
    bool selected,
    @required Widget title,
    bool highlight,
    @required GestureTapCallback onTap,
  }) =>
      FluidListItem(
        leading: leading,
        title: title,
        selected: selected,
        trailing: Icon(
          LiquidIcons.arrow_right,
          color: Liquids.richBlack.lightest,
        ),
        highlight: highlight,
        enabled: enabled,
        onTap: onTap,
      );

  @override
  _FluidListItemState createState() => _FluidListItemState();
}

class _FluidListItemState extends State<FluidListItem> {
  bool hovers = false;

  Color getColor(FluidThemeData theme) {
    if (widget.selected != null && widget.selected) return theme.primary;
    if (hovers != null && hovers) return theme.primary;
    if (widget.enabled != null && !widget.enabled) return theme.disabledColor;
    return theme.typography.baseColor;
  }

  void setHover([longPress = false]) {
    if (widget.onTap == null && widget.onLongPress == null) return;
    if (widget.enabled != null && !widget.enabled) return;
    if (widget.onTap != null && widget.onTap != null && !longPress)
      widget.onTap();
    if (widget.onTap != null && widget.onLongPress != null && longPress)
      widget.onLongPress();
    setState(() {
      hovers = true;
    });
    if (!longPress)
      Timer(
        Duration(milliseconds: 200),
        () => setState(
          () {
            hovers = false;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    var theme = FluidTheme.of(context);

    TextStyle titleTheme = theme.typography.largeBody;
    if (widget.highlight != null && widget.highlight)
      titleTheme = theme.typography.largeHighlight;
    titleTheme = titleTheme.apply(
      color: getColor(theme),
      fontWeightDelta: widget.selected != null && widget.selected ? 3 : 0,
    );

    return GestureDetector(
      onTap: () => setHover(),
      //onTapUp: (_) => setState(() => hovers = false),
      onLongPress: () => setHover(true),
      onLongPressEnd: (_) => setState(() => hovers = false),
      child: Container(
        height: 80,
        color: hovers ? theme.hoverColor.withAlpha(150) : Color(0x00),
        padding: const EdgeInsets.all(15.4),
        child: IconTheme.merge(
          data: IconThemeData(color: getColor(theme), size: 24),
          child: DefaultTextStyle(
            style: titleTheme,
            child: NavigationToolbar(
              leading: widget.leading != null
                  ? Padding(
                      padding: EdgeInsets.only(top: 5, right: 9),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [widget.leading]))
                  : null,
              middle: widget.title,
              centerMiddle: false,
              trailing: widget.trailing,
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   mainAxisSize: MainAxisSize.max,
            //   children: <Widget>[
            //     Row(
            //       children: <Widget>[
            //         if (widget.leading != null)
            //           Padding(
            //               padding: EdgeInsets.only(top: 5, right: 9),
            //               child: widget.leading),
            //         if (widget.title != null) widget.title,
            //       ],
            //     ),
            //     if (widget.trailing != null) widget.trailing,
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
