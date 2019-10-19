import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluix/theme/theme.dart';

class FluixApp extends StatelessWidget {
  final Color color;
  final FluidThemeData theme;
  final TextStyle textStyle;
  final Widget home;
  final TransitionBuilder builder;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final Map<String, WidgetBuilder> routes;
  final bool debugShowCheckedModeBanner;
  final GlobalKey<NavigatorState> navigatorKey;
  final Iterable<Locale> supportedLocales;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  /// {@macro flutter.widgets.widgetsApp.localeListResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleListResolutionCallback localeListResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.localeResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleResolutionCallback localeResolutionCallback;

  FluixApp({
    this.color,
    this.theme,
    this.textStyle,
    this.home,
    this.builder,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.debugShowCheckedModeBanner = true,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.routes = const <String, WidgetBuilder>{},
  });

  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates sync* {
    if (localizationsDelegates != null) yield* localizationsDelegates;
    yield DefaultMaterialLocalizations.delegate;
    yield DefaultCupertinoLocalizations.delegate;
  }

  @override
  Widget build(BuildContext context) {
    // Use a light theme, dark theme, or fallback theme.
    FluidThemeData theme;
    if (this.theme != null) {
      theme = this.theme;
    } else {
      theme = FluidThemeData.fallback();
    }

    return WidgetsApp(
      key: GlobalObjectKey(this),
      color: color ?? theme?.primary ?? Liquids.vibrantCyan,
      textStyle: textStyle ??
          theme?.typography?.mediumBody ??
          TextStyle(fontFamily: 'Lato'),
      home: home,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      navigatorKey: navigatorKey,
      supportedLocales: supportedLocales,
      onUnknownRoute: onUnknownRoute,
      onGenerateRoute: onGenerateRoute,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) =>
          MaterialPageRoute<T>(settings: settings, builder: builder),
      routes: routes,
      builder: (BuildContext context, Widget child) {
        return FluidTheme(
          data: theme,
          isFluidAppTheme: true,
          child: builder != null
              ? Builder(
                  builder: (BuildContext context) {
                    return builder(context, child);
                  },
                )
              : child,
        );
      },
      locale: locale,
      localizationsDelegates: _localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
      localeListResolutionCallback: localeListResolutionCallback,
    );
  }
}
