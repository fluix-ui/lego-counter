import 'package:fluix/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:fluix/theme/theme.dart';

const double kToolbarHeight = 60;

class FluidBar extends StatelessWidget implements PreferredSizeWidget {

  final Color color;
  final Widget title;
  final bool centerTitle;
  @override
  final Size preferredSize;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;

  FluidBar({this.color,this.title,this.centerTitle = false,double height,this.actions,this.automaticallyImplyLeading = true}):
    preferredSize = Size.fromHeight(height ?? kToolbarHeight); //+ (bottom?.preferredSize?.height ?? 0.0));

  @override
  Widget build(BuildContext context) {

    var theme = FluidTheme.of(context);
    var topPadding = MediaQuery.of(context).padding.top;
    var navigator = Navigator.of(context); 

    return Container(
      alignment: Alignment.centerLeft,
      color: color ?? theme.primary,
      child: Padding(
        padding: const EdgeInsets.all(16.0).add(EdgeInsets.only(top: topPadding)),
        child: DefaultTextStyle(
          style: theme.typography.h4.copyWith(color: Liquids.white),
          child: NavigationToolbar(
            centerMiddle: centerTitle,
            leading: navigator.canPop() && automaticallyImplyLeading ? FluidIconButton(
              icon: Icon(LiquidIcons.arrow_left),
              theme: FluidButtonTheme(
                null, Liquids.white
              ),
              height: 20,
              onTap: () => navigator.pop(),
            ): SizedBox(width: 0,),
            middle: title,
            trailing: actions != null ? Row(children: actions,mainAxisSize: MainAxisSize.min,) : SizedBox(width: 0,),
        ),
      ),
      ),
    );
  }
}