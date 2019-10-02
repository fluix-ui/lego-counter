import 'package:fluix/theme/colors.dart';

class SidebarTheme {
  Color background;
  Color foreground;
  Color selected;
  Color hover;
  Color selectedBackground;
  double iconSize;

  SidebarTheme(
    {
      this.background = Liquids.white,
      this.foreground = Liquids.richBlack,
      this.selected,
      this.hover,
      this.selectedBackground,
      this.iconSize = 24.0,
    }
  ){
    if(selectedBackground == null) selectedBackground = Liquids.sensitiveGrey.lighter;
  }

}