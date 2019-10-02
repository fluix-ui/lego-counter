import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fluix/theme/theme.dart';

class FluidButton extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final EdgeInsets padding;
  final ButtonAppearance appearance;
  final FluidButtonTheme theme;
  final double height;
  final bool small;
  final Color color;

  FluidButton({
    this.theme,
    this.child,
    this.height,
    this.small,
    this.appearance = ButtonAppearance.primary,
    this.color,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
  });

  factory FluidButton.primary({
    Widget child,
    GestureTapCallback onTap,
    double height,
    bool small,
  }) =>
      FluidButton(
        child: child,
        onTap: onTap,
        height: height,
        small: small,
        appearance: ButtonAppearance.primary,
      );
  factory FluidButton.secondary({
    Widget child,
    GestureTapCallback onTap,
    double height,
    bool small,
  }) =>
      FluidButton(
        child: child,
        onTap: onTap,
        height: height,
        small: small,
        appearance: ButtonAppearance.secondary,
      );
  factory FluidButton.highlight({
    Widget child,
    GestureTapCallback onTap,
    double height,
    bool small,
  }) =>
      FluidButton(
        child: child,
        onTap: onTap,
        height: height,
        small: small,
        appearance: ButtonAppearance.highlight,
      );
  factory FluidButton.ghost({
    Widget child,
    GestureTapCallback onTap,
    double height,
    bool small,
  }) =>
      FluidButton(
        child: child,
        onTap: onTap,
        height: height,
        small: small,
        appearance: ButtonAppearance.ghost,
      );

  @override
  _FluidButtonState createState() => _FluidButtonState();
}

class _FluidButtonState extends State<FluidButton> {
  Color color;
  Color foreColor;
  bool disabled = false;
  FluidButtonTheme theme;

  void setFocus(bool isFocus) {
    if (!disabled && theme.background != null)
      setState(() {
        color = (isFocus
                ? (theme.activeBackground ?? theme.background.dark)
                : theme.background) ??
            Liquids.transparent;
      });
  }

  void setActive() {
    if (!disabled) {
      if (widget.onTap != null) widget.onTap();
      if (theme.background != null) {
        setState(() {
          color = theme.activeBackground ?? theme.background.darker;
        });
        Timer(
          Duration(milliseconds: 100),
          () => setState(
            () {
              color = theme.background;
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = 50;
    if (widget.small != null && widget.small) height = 30;
    if (widget.height != null) height = widget.height;
    if (color == null) {
      theme = widget.theme;
      if (theme == null) {
        FluidThemeData appTheme = FluidTheme.of(context);
        switch (widget.appearance) {
          case ButtonAppearance.primary:
            theme = appTheme.primaryButton;
            break;
          case ButtonAppearance.secondary:
            theme = appTheme.secondaryButton;
            break;
          case ButtonAppearance.highlight:
            theme = appTheme.highlightButton;
            break;
          case ButtonAppearance.ghost:
            theme = appTheme.ghostButton.copyWith(foreground:widget.color);
            break;
          default:
            theme = appTheme.primaryButton;
        }
      } else
        assert(theme != null, "You have to provide a Button theme");

      if (theme.background != null)
        color = theme.background;
      else
        color = Liquids.transparent;
      foreColor = theme.foreground ?? Color(0xff000000);
      if (widget.onTap == null) {
        disabled = true;
        if (theme.background != null) color = theme.background.lightest;
        if (theme.disabledForeground != null)
          foreColor = theme.disabledForeground;
      }
    }

    return GestureDetector(
      onTap: () => setActive(),
      onTapCancel: () => setFocus(false),
      onTapDown: (_) => setFocus(true),
      child: Container(
        constraints: BoxConstraints(maxHeight: 50, maxWidth: 300),
        height: 50,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: IconTheme.merge(
          data: IconThemeData(color: foreColor, size: 20),
          child: DefaultTextStyle(
            style: TextStyle(
                color: foreColor, fontSize: 16, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class FluidIconButton extends StatelessWidget {
  final Icon icon;
  final Widget child;
  final GestureTapCallback onTap;
  final ButtonAppearance appearance;
  final FluidButtonTheme theme;
  final double height;
  final bool small;
  final Color color;

  FluidIconButton({
    this.child,
    this.appearance,
    this.theme,
    @required this.icon,
    this.height,
    this.small,
    this.onTap,
    this.color,
  });

  factory FluidIconButton.primary({
    Widget child,
    @required Icon icon,
    GestureTapCallback onTap,
    double height,
    bool small,
  }) =>
      FluidIconButton(
        icon: icon,
        child: child,
        onTap: onTap,
        height: height,
        small: small,
        appearance: ButtonAppearance.primary,
      );
  factory FluidIconButton.secondary({
    Widget child,
    @required Icon icon,
    GestureTapCallback onTap,
    double height,
    bool small,
  }) =>
      FluidIconButton(
        icon: icon,
        child: child,
        onTap: onTap,
        height: height,
        small: small,
        appearance: ButtonAppearance.secondary,
      );
  factory FluidIconButton.highlight({
    Widget child,
    @required Icon icon,
    GestureTapCallback onTap,
    double height,
    bool small,
  }) =>
      FluidIconButton(
        icon: icon,
        child: child,
        onTap: onTap,
        height: height,
        small: small,
        appearance: ButtonAppearance.highlight,
      );
  factory FluidIconButton.ghost({
    Widget child,
    @required Icon icon,
    GestureTapCallback onTap,
    double height,
    Color color,
    bool small,
  }) =>
      FluidIconButton(
        icon: icon,
        child: child,
        onTap: onTap,
        height: height,
        small: small,
        color: color,
        appearance: ButtonAppearance.ghost,
      );

  @override
  Widget build(BuildContext context) {
    return FluidButton(
      onTap: onTap,
      theme: theme,
      color: color,
      appearance: appearance,
      padding: child == null
          ? EdgeInsets.all(15)
          : EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) icon,
          if (child != null)
            Padding(
              padding: EdgeInsets.only(left: 11),
              child: child,
            )
        ],
      ),
    );
  }
}

enum ButtonAppearance { primary, secondary, highlight, ghost }

class FluidButtonTheme {
  Liquid background;
  Color activeBackground;
  Color foreground;
  Color disabledForeground;
  double cornerRadius;

  FluidButtonTheme(this.background, this.foreground,
      {this.disabledForeground, this.activeBackground, this.cornerRadius = 6}) {
    disabledForeground ??= foreground;
  }

  FluidButtonTheme copyWith({Liquid background, Color foreground,Color disabledForeground, Color activeBackground, double cornerRadius}){
    return FluidButtonTheme(
      background ?? this.background,
      foreground ?? this.foreground,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      activeBackground: activeBackground ?? this.activeBackground,
      cornerRadius: cornerRadius ?? this.cornerRadius,
    );
  }
}
