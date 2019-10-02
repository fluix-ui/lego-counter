import 'package:fluix/fluix.dart';
import 'package:fluix/theme/sidebar.dart';
import 'package:fluix/widgets/button.dart';
import 'package:fluix/widgets/sidebar-item.dart';
import 'package:flutter/material.dart';

class FluidSidebar extends StatefulWidget {
  final List<Widget> children;
  final double width;
  final bool expandable;
  final bool expanded;
  final bool showIconDescription;
  final SidebarTheme theme;

  FluidSidebar({this.children = const [],this.theme,this.expanded = false,this.showIconDescription,this.expandable = true, this.width = 200})
      : assert(width != null);

  @override
  _FluidSidebarState createState() => _FluidSidebarState();
}

class _FluidSidebarState extends State<FluidSidebar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void initState() {
    _expanded = widget.expanded;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = _controller.drive(CurveTween(curve: Curves.linearToEaseOut))
      ..addListener(() {
        setState(() {});
      });
    _controller.value = _expanded ? 1: 0 ;
  }

  bool _expanded = false;

  void expand() {
    _controller.forward();
  }

  void shrink() {
    _controller.reverse();
  }

  void toggle() {
    _expanded = !_expanded;
    _expanded ? expand() : shrink();
  }

  List<Widget> get children => widget.children.map((child){
    if(child is SidebarItem && child.expanded != _expanded) return child.copyWith(expanded: _expanded,theme:widget.theme,showIconDescription: widget.showIconDescription);
    return child;
  }).toList();

  @override
  Widget build(BuildContext context) {

    var theme = widget.theme ?? FluidTheme.of(context).sidebar;

    //print(children);
    return Container(
      width: _animation.value * (widget.width - 80) + 80,
      color: theme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: ListView(children: children)),
          if(widget.expandable) FluidButton.ghost(
            onTap: () => toggle(),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 100),
              firstChild: Icon(LiquidIcons.listview),
              secondChild: Icon(LiquidIcons.close),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
          ),
          if(widget.expandable) SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}