import 'package:fluix/theme/theme.dart';
import 'package:flutter/material.dart';

class FluidTabs extends StatefulWidget {
  final List<FluidTab> tabs;
  final int selected;
  final void Function(int) onChange;
  final MainAxisAlignment alignment;

  FluidTabs(this.tabs, {this.selected, this.onChange,this.alignment = MainAxisAlignment.start}) : assert(tabs != null);

  @override
  _FluidTabsState createState() => _FluidTabsState();
}

class _FluidTabsState extends State<FluidTabs> {
  int selected;
  Widget content;

  @override
  void initState() {
    selected = widget.selected ?? 0;
    super.initState();
  }

  FluidTab getTab(FluidTab tab) {
    int index = widget.tabs.indexOf(tab);
    if (index == selected) return tab.copyWith(selected: true);
    return tab;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: widget.alignment,
          children: widget.tabs.map<Widget>(
            (FluidTab tab) => GestureDetector(
              onTap: () => setState(() {
                selected = widget.tabs.indexOf(tab);
                if(widget.onChange != null) widget.onChange(selected);
              }),
              child: getTab(tab),
            ),
          ).toList(),
        ),
        SizedBox(height: 8,),
        widget.tabs[selected].child ?? SizedBox()
      ],
    );
  }
}

class FluidTab extends StatelessWidget {
  final String text;
  final bool _selected;
  final Widget child;

  FluidTab(this.text, {bool selected, this.child}) : this._selected = selected;

  bool get selected => _selected != null ? _selected : false;

  FluidTab copyWith({String text, bool selected, Widget child}) => FluidTab(
        text ?? this.text,
        selected: selected ?? _selected,
        child: child ?? this.child,
      );

  @override
  Widget build(BuildContext context) {
    var theme = FluidTheme.of(context);

    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: theme.typography.mediumHighlight
            .copyWith(color: selected ? theme.primary : null),
      ),
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        border: selected
            ? Border(
                bottom: BorderSide(
                  width: 2,
                  color: theme.primary,
                ),
              )
            : null,
        color: theme.tabsColor,
      ),
    );
  }
}
