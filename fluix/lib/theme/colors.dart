


import 'package:flutter/painting.dart' show Color, ColorSwatch;
export 'package:flutter/painting.dart' show Color, ColorSwatch;

class Liquids {
  static const Liquid richPurple = Liquid(
    4283445905,
    {
      "darkest": Color(0xff281949),
      "darker": Color(0xff382366),
      "dark": Color(0xff482D83),
      "standard": Color(0xff503291),
      "light": Color(0xff735BA7),
      "lighter": Color(0xff9684BD),
      "lightest": Color(0xffB9ADD3),
    }
  );
  static const Liquid vibrantMagenta = Liquid(
    4293606550,
    {
      "darkest": Color(0xff761E4B),
      "darker": Color(0xffA52A69),
      "dark": Color(0xffD43687),
      "standard": Color(0xffEB3C96),
      "light": Color(0xffEF63AB),
      "lighter": Color(0xffF38AC0),
      "lightest": Color(0xffF7B1D5),
    }
  );
  static const Liquid richBlue = Liquid(
    4279200175,
    {
      "darkest": Color(0xff083558),
      "darker": Color(0xff0B4A7B),
      "dark": Color(0xff0E5F9E),
      "standard": Color(0xff0F69AF),
      "light": Color(0xff3F87B),
      "lighter": Color(0xff6FA5CF),
      "lightest": Color(0xff9FC3DF),
    }
  );
  static const Liquid vibrantCyan = Liquid(
    4281188045,
    {
      "darkest": Color(0xff175F67),
      "darker": Color(0xff208590),
      "dark": Color(0xff29ABB9),
      "standard": Color(0xff2DBECD),
      "light": Color(0xff57CBD7),
      "lighter": Color(0xff81D8E1),
      "lightest": Color(0xffABE5EB),
    }
  );
  static const Liquid vibrantYellow = Liquid(
    4294953010,
    {
      "darkest": Color(0xff806419),
      "darker": Color(0xffDDAC28),
      "dark": Color(0xffF3BE2F),
      "standard": Color(0xffFFC832),
      "light": Color(0xffFFD35B),
      "lighter": Color(0xffFFDE84),
      "lightest": Color(0xffFFDE84),
    }
  );

  static const Liquid vibrantGreen = Liquid(
    4289056080,
    {
      "darkest": Color(0xff536728),
      "darker": Color(0xff749038),
      "dark": Color(0xff95B948),
      "standard": Color(0xffA5CD50),
      "light": Color(0xffB7D773),
      "lighter": Color(0xffC9E196),
      "lightest": Color(0xffDBEBB9),
    }
  );
  static const Liquid richRed = Liquid(
    4293271120,
    {
      "darkest": Color(0xff730F28),
      "darker": Color(0xffA11538),
      "dark": Color(0xffCF1B48),
      "standard": Color(0xffE61E50),
      "light": Color(0xffEB4B73),
      "lighter": Color(0xffF07896),
      "lightest": Color(0xffF5A5B9),
    }
  );

  static const Liquid richGreen = Liquid(
    4279069762,
    {
      "darkest": Color(0xff094D2F),
      "darker": Color(0xff0C5D39),
      "dark": Color(0xff0D6C42),
      "standard": Color(0xff0D6C42),
      "light": Color(0xff5AB98F),
      "lighter": Color(0xff72C39F),
      "lightest": Color(0xff89CDAF),
    }
  );

  static const Liquid richBlack = Liquid(
    4282992979,
    {
      "darkest": Color(0xff000000),
      "darker": Color(0xff000000),
      "dark": Color(0xff1B1B25),
      "standard": Color(0xff494953),
      "light": Color(0xff767680),
      "lighter": Color(0xffA4A4AE),
      "lightest": Color(0xffD5D5D9),
    }
  );
  static const Liquid sensitiveGrey = Liquid(
    4294506748,
    {
      "darkest": Color(0xffD5D5D9),
      "darker": Color(0xffE9E9ED),
      "dark": Color(0xffF3F3F7),
      "standard": Color(0xffF8F8FC),
      "light": Color(0xffF9F9FD),
      "lighter": Color(0xffFBFBFD),
      "lightest": Color(0xffFCFCFE),
    }
  );

  static const Liquid transparent = Liquid(
    0,
    {
      "darkest": Color(0),
      "darker": Color(0),
      "dark": Color(0),
      "standard": Color(0),
      "light": Color(0),
      "lighter": Color(0),
      "lightest": Color(0),
    }
  );
  static const Color black = Color(0xff494953);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xffF8F8FC);

  static const Color sensitiveGreen = Color(0xffB4DC96);
  static const Color sensitiveYellow = Color(0xffFFDCB9);
  static const Color sensitiveBlue = Color(0xff96D7D2);
  static const Color sensitivePink = Color(0xffE1C3CD);
}

class Liquid extends ColorSwatch<String> {

  final int primary;
  final Map<String,Color> swatch;

  const Liquid(this.primary,this.swatch): super(primary, swatch);

  /// The lightest shade.
  Color get lightest => this["lightest"];

  /// The second lightest shade.
  Color get lighter => this["lighter"];

  /// The third lightest shade.
  Color get light => this["light"];

  /// The default shade.
  Color get standard => this["standard"];

  /// The third darkest shade.
  Color get dark => this["dark"];

  /// The second darkest shade.
  Color get darker => this["darker"];

  /// The darkest shade.
  Color get darkest => this["darkest"];
}