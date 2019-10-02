import 'package:flutter/widgets.dart';
import 'package:fluix/theme/theme.dart';

class FluidRadio<T> extends StatefulWidget {

  final ValueChanged<T> onChanged;
  final T value;
  final Color activeColor;
  final T groupValue;
  final Widget label;

  FluidRadio({this.value,this.groupValue,this.onChanged,this.label,this.activeColor});

  @override
  _FluidRadioState createState() => _FluidRadioState();
}

class _FluidRadioState extends State<FluidRadio> {
  bool isFocused = false;
  bool isDisabled = false;
    void focus(bool shouldFocus) {
    if (!isDisabled) {
      setState(() {
        isFocused = shouldFocus;
      });
    }
  }

  void setValue() {
    if (!isDisabled) {
      widget.onChanged(widget.value);
      setState(() {
        isFocused = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.value == null || widget.groupValue == null) isDisabled = true;
    if(widget.onChanged == null) isDisabled = true;
  }

  @override
  Widget build(BuildContext context) {

    var theme = FluidTheme.of(context);
    Color active = widget.activeColor ?? theme.primary;
    bool isSelected = widget.groupValue == widget.value; 

    Widget radio = Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(
          color: isFocused || isSelected ? active : theme.disabledColor,
          width: isSelected ? 7 : 2,  
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: isFocused && isSelected 
              ? [BoxShadow(blurRadius: 2, color: Color(0x0a00000))]
              : null,
      ),
    );

    if(widget.label != null) radio = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        radio,
        Padding(
            padding: EdgeInsets.only(left: 8),
            child:DefaultTextStyle(
          style: TextStyle(color: isDisabled ? theme.labelColor : Liquids.richBlack ),
          child: widget.label,
        ),
        ),
      ],
    );

    return GestureDetector(
      onTapDown: (_) => focus(true),
      onTapCancel: () => focus(false),
      onTapUp: (_) => setValue(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: radio,
      ),
    );

  }
}