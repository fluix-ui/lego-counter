import 'package:fluix/theme/sidebar.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:fluix/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluix/theme/textTheme.dart';

import 'package:fluix/widgets/button.dart';

class FluidThemeData {
  Liquid primary;
  Liquid accent;
  Color background;
  Color hintColor;
  Color inputBackground;
  Color toggleBackground;
  Color disabledInput;
  Color disabledColor;
  Color errorColor;
  Color labelColor;
  Color cardColor;
  Color hoverColor;
  Color tabsColor;
  SidebarTheme sidebar;
  FluidBrightness brightness;
  FluidButtonTheme primaryButton;
  FluidButtonTheme secondaryButton;
  FluidButtonTheme highlightButton;
  FluidButtonTheme ghostButton;
  IconThemeData iconTheme;
  FluixTypography typography;
  TextStyle defaultTextStyle;
  String fontFamily;

  FluidThemeData(
      {@required this.primary,
      @required this.accent,
      this.background,
      this.brightness = FluidBrightness.normal,
      this.hintColor,
      this.iconTheme,
      this.hoverColor,
      this.inputBackground,
      this.toggleBackground,
      this.disabledInput,
      this.disabledColor,
      this.sidebar,
      this.errorColor,
      this.labelColor,
      this.primaryButton,
      this.typography,
      this.tabsColor,
      this.defaultTextStyle,
      this.fontFamily = "Lato",
      this.cardColor,
      this.highlightButton})
      : assert(primary != null),
        assert(accent != null) {
    primaryButton ??= FluidButtonTheme(
      this.primary,
      Liquids.white,
      disabledForeground: Color(0x7FFFFFFF),
    );
    toggleBackground ??= Liquids.sensitiveGrey.dark;
    secondaryButton ??= FluidButtonTheme(
      Liquids.sensitiveGrey,
      this.primary,
      disabledForeground: Liquids.sensitiveGrey.darker,
    );
    highlightButton ??= FluidButtonTheme(
      this.accent,
      Liquids.black,
      disabledForeground: Color(0x4C000000),
    );
    ghostButton ??= FluidButtonTheme(
      null,
      this.primary,
      disabledForeground: Color(0x4C000000),
      activeBackground: Liquids.sensitiveGrey.lighter.withAlpha(20),
    );

    iconTheme ??= IconThemeData(color: Liquids.richBlack, size: 20, opacity: 1);

    defaultTextStyle ??= TextStyle(fontFamily: "Lato");

    final FluixTypography defaultTextTheme = FluixTypography.defaults();
    typography = defaultTextTheme.merge(typography);

    typography = typography.apply(TextStyle(
      fontFamily: fontFamily ?? 'Lato',
      fontFamilyFallback: ['Roboto', 'sans-serif'],
      color: Liquids.black,
    ));

    if (brightness == FluidBrightness.normal) {
      inputBackground ??= Liquids.white;
      background ??= Liquids.sensitiveGrey;
      cardColor ??= Liquids.white;
      sidebar ??= SidebarTheme();
    }
    if (brightness == FluidBrightness.light) {
      inputBackground ??= Liquids.sensitiveGrey;
      background ??= Liquids.white;
      cardColor ??= Liquids.sensitiveGrey;
      sidebar ??= SidebarTheme(
        background: Liquids.sensitiveGrey,
      );
      print(background);
    }

    if (brightness == FluidBrightness.dark) {
    } else {
      hintColor ??= Liquids.richBlack.lightest;
      labelColor ??= Liquids.richBlack.lightest;
      disabledColor ??= Liquids.sensitiveGrey.darker;
      hoverColor ??= Liquids.sensitiveGrey.darker;
      tabsColor ??= Liquids.sensitiveGrey.standard;
    }
  }

  factory FluidThemeData.vibrantCyan(
          {FluidBrightness brightness = FluidBrightness.normal}) =>
      FluidThemeData(
        primary: Liquids.vibrantCyan,
        accent: Liquids.vibrantYellow,
        brightness: brightness,
        errorColor: Liquids.richRed,
      );
  factory FluidThemeData.richBlue(
          {FluidBrightness brightness = FluidBrightness.normal}) =>
      FluidThemeData(
        primary: Liquids.richBlue,
        accent: Liquids.vibrantYellow,
        brightness: brightness,
        errorColor: Liquids.richRed,
      );
  factory FluidThemeData.richPurple(
          {FluidBrightness brightness = FluidBrightness.normal}) =>
      FluidThemeData(
        primary: Liquids.richPurple,
        accent: Liquids.vibrantCyan,
        brightness: brightness,
        errorColor: Liquids.richRed,
        //iconTheme: IconThemeData(color: Liquids.richBlack,size: 20,opacity: 1)
      );
  factory FluidThemeData.vibrantMagenta(
          {FluidBrightness brightness = FluidBrightness.normal}) =>
      FluidThemeData(
        primary: Liquids.vibrantMagenta,
        accent: Liquids.richPurple,
        brightness: brightness,
        errorColor: Liquids.richRed,
        //iconTheme: IconThemeData(color: Liquids.richBlack,size: 20,opacity: 1)
      );
  factory FluidThemeData.fallback() => FluidThemeData.vibrantCyan();
}

enum FluidBrightness { light, normal, dark }
