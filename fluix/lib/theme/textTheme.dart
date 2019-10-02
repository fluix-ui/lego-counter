import 'package:flutter/painting.dart';

class FluixTypography {
  TextStyle xH1;
  TextStyle xH2;
  TextStyle xH3;
  TextStyle xH4;
  TextStyle xH5;
  TextStyle xH6;
  TextStyle h1;
  TextStyle h2;
  TextStyle h3;
  TextStyle h4;
  TextStyle h5;
  TextStyle h6;
  TextStyle xlargeBody;
  TextStyle largeBody;
  TextStyle mediumBody;
  TextStyle smallBody;
  TextStyle xsmallBody;
  TextStyle smallHighlight;
  TextStyle mediumHighlight;
  TextStyle largeHighlight;
  TextStyle label;
  Color baseColor;

  FluixTypography(
      {this.label,
      this.h1,
      this.h2,
      this.h3,
      this.h4,
      this.h5,
      this.h6,
      this.largeBody,
      this.largeHighlight,
      this.mediumBody,
      this.mediumHighlight,
      this.smallBody,
      this.smallHighlight,
      this.xH1,
      this.xH2,
      this.xH3,
      this.xH4,
      this.xH5,
      this.xH6,
      this.xlargeBody,
      this.baseColor,
      this.xsmallBody}) {
    _setDefaults();
  }

  FluixTypography.defaults(){
    _setDefaults();
  }

  _setDefaults() {
    xH1 ??= TextStyle(fontSize: 92, fontWeight: FontWeight.w900);
    xH2 ??= TextStyle(fontSize: 72, fontWeight: FontWeight.w900);
    xH3 ??= TextStyle(fontSize: 64, fontWeight: FontWeight.w900);
    xH4 ??= TextStyle(fontSize: 64, fontWeight: FontWeight.w900);
    xH5 ??= TextStyle(fontSize: 40, fontWeight: FontWeight.w900);
    xH6 ??= TextStyle(fontSize: 36, fontWeight: FontWeight.w900);
    h1 ??= TextStyle(fontSize: 32, fontWeight: FontWeight.w900);
    h2 ??= TextStyle(fontSize: 26, fontWeight: FontWeight.w900);
    h3 ??= TextStyle(fontSize: 22, fontWeight: FontWeight.w900);
    h4 ??= TextStyle(fontSize: 18, fontWeight: FontWeight.w900);
    h5 ??= TextStyle(fontSize: 16, fontWeight: FontWeight.w900);
    h6 ??= TextStyle(fontSize: 14, fontWeight: FontWeight.w900);
    xlargeBody ??=
        TextStyle(fontSize: 22, fontWeight: FontWeight.w400, height: 1.75);
    largeBody ??=
        TextStyle(fontSize: 18, fontWeight: FontWeight.w400, height: 1.75);
    mediumBody ??=
        TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.75);
    smallBody ??=
        TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.75);
    xsmallBody ??=
        TextStyle(fontSize: 21, fontWeight: FontWeight.w400, height: 1.75);
    label ??= TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.27,height: 1.75);
    smallHighlight ??= TextStyle(fontSize: 14, fontWeight: FontWeight.w800);
    mediumHighlight ??= TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
    largeHighlight ??=
        TextStyle(fontSize: 18, fontWeight: FontWeight.w800, height: 1.75);
    baseColor = Color(0xff000000);
  }

  FluixTypography copyWith({
    TextStyle xH1,
    TextStyle xH2,
    TextStyle xH3,
    TextStyle xH4,
    TextStyle xH5,
    TextStyle xH6,
    TextStyle h1,
    TextStyle h2,
    TextStyle h3,
    TextStyle h4,
    TextStyle h5,
    TextStyle h6,
    TextStyle xlargeBody,
    TextStyle largeBody,
    TextStyle mediumBody,
    TextStyle smallBody,
    TextStyle xsmallBody,
    TextStyle smallHighlight,
    TextStyle mediumHighlight,
    TextStyle largeHighlight,
    TextStyle label,
  }) {
    return FluixTypography(
      xH1: xH1 ?? this.xH1,
      xH2: xH2 ?? this.xH2,
      xH3: xH3 ?? this.xH3,
      xH4: xH4 ?? this.xH4,
      xH5: xH5 ?? this.xH5,
      xH6: xH6 ?? this.xH6,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      xlargeBody: xlargeBody ?? this.xlargeBody,
      largeBody: largeBody ?? this.largeBody,
      mediumBody: mediumBody ?? this.mediumBody,
      smallBody: smallBody ?? this.smallBody,
      xsmallBody: xsmallBody ?? this.xsmallBody,
      label: label ?? this.label,
      largeHighlight: largeHighlight ?? this.largeHighlight,
      mediumHighlight: mediumHighlight ?? this.mediumHighlight,
      smallHighlight: smallHighlight ?? this.smallHighlight,
    );
  }
    FluixTypography merge(FluixTypography other) {
    if (other == null)
      return this;
    return copyWith(
      xH1: xH1.merge(other.xH1),
      xH2: xH2.merge(other.xH2),
      xH3: xH3.merge(other.xH3),
      xH4: xH4.merge(other.xH4),
      xH5: xH5.merge(other.xH5),
      xH6: xH6.merge(other.xH6),
      h1: h1.merge(other.h1),
      h2: h2.merge(other.h2),
      h3: h3.merge(other.h3),
      h4: h4.merge(other.h4),
      h5: h5.merge(other.h5),
      h6: h6.merge(other.h6),
      xlargeBody: xlargeBody.merge(other.xlargeBody),
      largeBody: largeBody.merge(other.largeBody),
      mediumBody: mediumBody.merge(other.mediumBody),
      smallBody: smallBody.merge(other.smallBody),
      xsmallBody: xsmallBody.merge(other.xsmallBody),
      label: label.merge(other.label),
      largeHighlight: largeHighlight.merge(other.largeHighlight),
      mediumHighlight: mediumHighlight.merge(other.mediumHighlight),
      smallHighlight: smallHighlight.merge(other.smallHighlight),
    );
  }
    FluixTypography apply(TextStyle other) {
    if (other == null)
      return this;
    return copyWith(
      xH1: xH1.merge(other),
      xH2: xH2.merge(other),
      xH3: xH3.merge(other),
      xH4: xH4.merge(other),
      xH5: xH5.merge(other),
      xH6: xH6.merge(other),
      h1: h1.merge(other),
      h2: h2.merge(other),
      h3: h3.merge(other),
      h4: h4.merge(other),
      h5: h5.merge(other),
      h6: h6.merge(other),
      xlargeBody: xlargeBody.merge(other),
      largeBody: largeBody.merge(other),
      mediumBody: mediumBody.merge(other),
      smallBody: smallBody.merge(other),
      xsmallBody: xsmallBody.merge(other),
      label: label.merge(other),
      largeHighlight: largeHighlight.merge(other),
      mediumHighlight: mediumHighlight.merge(other),
      smallHighlight: smallHighlight.merge(other),
    );
  }
}
